package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/bluefin-decryptx-sdk/go"
	"github.com/voxgig-sdk/bluefin-decryptx-sdk/go/core"

	vs "github.com/voxgig-sdk/bluefin-decryptx-sdk/go/utility/struct"
)

func TestDecryptEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Decrypt(nil)
		if ent == nil {
			t.Fatal("expected non-nil DecryptEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"decrypt": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.Decrypt(nil).Stream("list", nil, nil) {
			seen = append(seen, item)
		}
		if len(seen) != 3 {
			t.Fatalf("expected 3 streamed items, got %d", len(seen))
		}

		// Inbound: streaming active -> yields each item from the feature iterator.
		hasStreaming := false
		if fm, ok := core.MakeConfig()["feature"].(map[string]any); ok {
			_, hasStreaming = fm["streaming"]
		}
		if hasStreaming {
			streamSdk := sdk.TestSDK(seed, map[string]any{
				"feature": map[string]any{"streaming": map[string]any{"active": true}},
			})
			var got []any
			for item := range streamSdk.Decrypt(nil).Stream("list", nil, nil) {
				if sub, ok := item.([]any); ok {
					got = append(got, sub...)
				} else {
					got = append(got, item)
				}
			}
			if len(got) != 3 {
				t.Fatalf("expected 3 items via streaming feature, got %d", len(got))
			}
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := decryptBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "decrypt." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		decryptRef01Ent := client.Decrypt(nil)
		decryptRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "decrypt"}, setup.data), "decrypt_ref01"))

		decryptRef01DataResult, err := decryptRef01Ent.Create(decryptRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		decryptRef01Data = core.ToMapAny(decryptRef01DataResult)
		if decryptRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

		// LIST
		decryptRef01Match := map[string]any{}

		decryptRef01ListResult, err := decryptRef01Ent.List(decryptRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, decryptRef01ListOk := decryptRef01ListResult.([]any)
		if !decryptRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", decryptRef01ListResult)
		}

	})
}

func decryptBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "decrypt", "DecryptTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read decrypt test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse decrypt test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"decrypt01", "decrypt02", "decrypt03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("BLUEFINDECRYPTX_TEST_DECRYPT_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFINDECRYPTX_TEST_DECRYPT_ENTID": idmap,
		"BLUEFINDECRYPTX_TEST_LIVE":      "FALSE",
		"BLUEFINDECRYPTX_TEST_EXPLAIN":   "FALSE",
		"BLUEFINDECRYPTX_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["BLUEFINDECRYPTX_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["BLUEFINDECRYPTX_APIKEY"],
			},
			extra,
		})
		client = sdk.NewBluefinDecryptxSDK(core.ToMapAny(mergedOpts))
	}

	live := env["BLUEFINDECRYPTX_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["BLUEFINDECRYPTX_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}

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

func TestDecryptExtEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.DecryptExt(nil)
		if ent == nil {
			t.Fatal("expected non-nil DecryptExtEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := decrypt_extBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "decrypt_ext." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		decryptExtRef01Ent := client.DecryptExt(nil)
		decryptExtRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "decrypt_ext"}, setup.data), "decrypt_ext_ref01"))

		decryptExtRef01DataResult, err := decryptExtRef01Ent.Create(decryptExtRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		decryptExtRef01Data = core.ToMapAny(decryptExtRef01DataResult)
		if decryptExtRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

	})
}

func decrypt_extBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "decrypt_ext", "DecryptExtTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read decrypt_ext test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse decrypt_ext test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"decrypt_ext01", "decrypt_ext02", "decrypt_ext03"},
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
	entidEnvRaw := os.Getenv("BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID": idmap,
		"BLUEFINDECRYPTX_TEST_LIVE":      "FALSE",
		"BLUEFINDECRYPTX_TEST_EXPLAIN":   "FALSE",
		"BLUEFINDECRYPTX_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"])
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

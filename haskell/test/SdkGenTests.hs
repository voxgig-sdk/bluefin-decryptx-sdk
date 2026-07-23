-- Generated model-driven entity + direct tests.
{-# LANGUAGE ScopedTypeVariables #-}

module SdkGenTests (genTests) where

import Control.Exception (SomeException, try)
import Data.IORef

import VoxgigStruct (Value (..), emptyMap, keysof, ismap, islist, isNoval, clone)
import SdkTypes
import SdkHelpers
import qualified SdkFeatures as F
import qualified SdkClient as C
import qualified TReadmeExamples
import Testutil
import TestJson (jsonRead)

-- Load an entity fixture (../.sdk/test/entity/<name>/<Name>TestData.json).
loadFixture :: String -> IO Value
loadFixture entName = do
  -- The fixture DIRECTORY is the snake_case entity name (create_result), so a
  -- plain lowercase of the CamelCase entName (createresult) misses the
  -- underscores for multi-word entities. Convert CamelCase -> snake_case.
  let lname = camelToSnake entName
  raw <- readFile ("../.sdk/test/entity/" ++ lname ++ "/" ++ entName ++ "TestData.json")
  jsonRead raw
  where
    toLowerCh ch = if ch >= 'A' && ch <= 'Z' then toEnum (fromEnum ch + 32) else ch
    camelToSnake [] = []
    camelToSnake (c0 : rest) = toLowerCh c0 : go rest
    go [] = []
    go (c : cs)
      | c >= 'A' && c <= 'Z' = '_' : toLowerCh c : go cs
      | otherwise = c : go cs

-- The first new-ref data map for an entity (fixture.new.<entity>.<ref0>).
newRefData :: Value -> String -> IO Value
newRefData fixture entName = do
  newEnts <- getpathS fixture ("new." ++ entName)
  refs <- keysof newEnts
  case refs of
    [] -> emptyMap
    (r0 : _) -> do d <- getp newEnts r0; clone d

genTests :: Counters -> IO ()
genTests c = do
  TReadmeExamples.tests c
  decryptInstanceTest c
  decryptBasicTest c
  decryptDirectTest c
  decryptStreamTest c
  decrypt_extInstanceTest c
  decrypt_extBasicTest c
  decrypt_extDirectTest c
  validationInstanceTest c
  validationBasicTest c
  validationDirectTest c

decryptInstanceTest :: Counters -> IO ()
decryptInstanceTest c = runTest c "decrypt.instance" $ do
  sdk <- C.testSdk0
  ent <- C.decrypt sdk VNoval
  pure (eName ent == "decrypt")

decryptBasicTest :: Counters -> IO ()
decryptBasicTest c = do
  fixture <- loadFixture "Decrypt"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "decrypt.list" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.decrypt sdk VNoval
    em1 <- emptyMap; em2 <- emptyMap
    lst <- eList ent em1 em2
    pure (islist lst)
  runTest c "decrypt.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.decrypt sdk VNoval
    d <- newRefData fixture "decrypt"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

decryptDirectTest :: Counters -> IO ()
decryptDirectTest c = runTest c "decrypt.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/decrypt/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

decryptStreamTest :: Counters -> IO ()
decryptStreamTest c = do
  let mkSeed = do
        r1 <- jo [("id", VStr "S1"), ("name", VStr "a")]
        r2 <- jo [("id", VStr "S2"), ("name", VStr "b")]
        r3 <- jo [("id", VStr "S3"), ("name", VStr "c")]
        recs <- jo [("S1", r1), ("S2", r2), ("S3", r3)]
        jo [("decrypt", recs)]
      hasStreaming = do
        sdk0 <- C.testSdk0
        fs <- getp (clConfig sdk0) "feature"
        st <- getp fs "streaming"
        pure (not (isNoval st))
  runTest c "decrypt.stream" $ do
    seed <- mkSeed; opts <- jo [("entity", seed)]
    sdk <- C.testSdk opts VNoval
    ent <- C.decrypt sdk VNoval
    em1 <- emptyMap
    items <- eStream ent "list" em1 VNoval
    pure (length items == 3 && (case items of (x : _) -> ismap x; [] -> False))
  runTest c "decrypt.stream_signal" $ do
    seed <- mkSeed; opts <- jo [("entity", seed)]
    sdk <- C.testSdk opts VNoval
    ent <- C.decrypt sdk VNoval
    em1 <- emptyMap
    n <- newIORef (0 :: Int)
    let sig = vfunc0 (do modifyIORef n (+ 1); v <- readIORef n; pure (VBool (v >= 2)))
    co <- jo [("signal", sig)]
    items <- eStream ent "list" em1 co
    pure (length items == 1)
  runTest c "decrypt.stream_active" $ do
    hs <- hasStreaming
    if not hs then pure True else do
      seed <- mkSeed; opts <- jo [("entity", seed)]
      stg <- jo [("active", VBool True)]; strm <- jo [("streaming", stg)]; sopts <- jo [("feature", strm)]
      sdk <- C.testSdk opts sopts
      ent <- C.decrypt sdk VNoval
      em1 <- emptyMap
      items <- eStream ent "list" em1 VNoval
      pure (length items == 3)
  runTest c "decrypt.stream_chunk" $ do
    hs <- hasStreaming
    if not hs then pure True else do
      seed <- mkSeed; opts <- jo [("entity", seed)]
      stg <- jo [("active", VBool True), ("chunkSize", VNum 2)]; strm <- jo [("streaming", stg)]; sopts <- jo [("feature", strm)]
      sdk <- C.testSdk opts sopts
      ent <- C.decrypt sdk VNoval
      em1 <- emptyMap
      batches <- eStream ent "list" em1 VNoval
      pure (length batches == 2)

decrypt_extInstanceTest :: Counters -> IO ()
decrypt_extInstanceTest c = runTest c "decrypt_ext.instance" $ do
  sdk <- C.testSdk0
  ent <- C.decrypt_ext sdk VNoval
  pure (eName ent == "decrypt_ext")

decrypt_extBasicTest :: Counters -> IO ()
decrypt_extBasicTest c = do
  fixture <- loadFixture "DecryptExt"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "decrypt_ext.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.decrypt_ext sdk VNoval
    d <- newRefData fixture "decrypt_ext"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

decrypt_extDirectTest :: Counters -> IO ()
decrypt_extDirectTest c = runTest c "decrypt_ext.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/decrypt_ext/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

validationInstanceTest :: Counters -> IO ()
validationInstanceTest c = runTest c "validation.instance" $ do
  sdk <- C.testSdk0
  ent <- C.validation sdk VNoval
  pure (eName ent == "validation")

validationBasicTest :: Counters -> IO ()
validationBasicTest c = do
  fixture <- loadFixture "Validation"
  existing <- getp fixture "existing"
  opts <- jo [("entity", existing)]
  runTest c "validation.create" $ do
    sdk <- C.testSdk opts VNoval
    ent <- C.validation sdk VNoval
    d <- newRefData fixture "validation"
    ctrl <- emptyMap
    created <- eCreate ent d ctrl
    cid <- getp created "id"
    pure (ismap created && not (isNoval cid))

validationDirectTest :: Counters -> IO ()
validationDirectTest c = runTest c "validation.direct" $ do
  calls <- newIORef (0 :: Int)
  let mock = VFunc (\_ _ _ _ -> do
        modifyIORef calls (+ 1)
        d <- jo [("id", VStr "direct01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk d)])
  sys <- jo [("fetch", mock)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  sdk <- C.newSdk opts
  args <- jo [("path", VStr "/validation/x"), ("method", VStr "GET")]
  res <- F.direct sdk args
  ok <- getp res "ok"
  st <- getp res "status"
  dat <- getp res "data"
  did <- getp dat "id"
  n <- readIORef calls
  pure (isTrueV ok && toInt st == 200 && vstring did == "direct01" && n == 1)

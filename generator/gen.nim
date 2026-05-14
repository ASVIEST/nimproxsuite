import pkg/henka
import std/os

var outp = generate(
  @[
    getCurrentDir()/"deps"/
    "vendor/cproxsuite"/
    "generated/proxsuite_c_api.h"],
  singleFileParse = false,
  isCpp = true)

writeFile(
    "src/nimproxsuite.nim",
    outp.modules[0].definitions)

import pkg/henka
import std/[os, strutils]

const
  cproxsuiteLibName = "cproxsuiteLib"
  cproxsuiteLibDefault = "libcproxsuite.so"
  cproxsuiteLibDefinition = """

when defined(macosx):
  {.error: "nimproxsuite does not support macOS yet".}

const cproxsuiteLib* {.strdefine.} =
  when defined(windows):
    "cproxsuite.dll"
  else:
    "libcproxsuite.so"

when defined(feature.nimproxsuite.linkStatic):
  const cproxsuiteStaticLib* {.strdefine: "nimproxsuite.staticLib".} = "libcproxsuite.a"

  {.passL: cproxsuiteStaticLib.}
  when defined(windows):
    # UCRT automaticly links math
    {.passL: "-lc++".}
  elif defined(linux):
    {.passL: "-lc++".}
    {.passL: "-lm".}
"""

proc fixDynlibOutput(definitions: string): string =
  # henka shouldn't add '"' because it makes this code
  result = definitions
    .replace(
      "const " & cproxsuiteLibName & "* {.strdefine.} = \"\"" &
        cproxsuiteLibDefault & "\"\"",
      cproxsuiteLibDefinition)
    .replace(
      "dynlib:\"" & cproxsuiteLibName & "\"",
      "dynlib:" & cproxsuiteLibName)

var outp = generate(
  @[
    getCurrentDir()/"deps"/
    "vendor/cproxsuite"/
    "generated/proxsuite_c_api.h"],
  singleFileParse = false,
  isCpp = true,
  linkMode = LinkMode.dynlib,
  dynlibName = cproxsuiteLibName,
  dynlibPath = cproxsuiteLibDefault)

writeFile(
    "src/nimproxsuite.nim",
    fixDynlibOutput(outp.modules[0].definitions))

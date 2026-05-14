mode = ScriptMode.Verbose
version = "0.1.0"
author = "ASVIEST"
description = "nim bindings to ProxSuite"
license = "BSD-2-Clause"
srcDir = "src"

feature "gen":
  requires "https://github.com/ASVIEST/henka#externc"

after install:
  if dirExists("deps/henka") and not dirExists("deps/vendor/cproxsuite"):
    mkDir "deps/vendor"

    exec "git clone --depth 1 " &
      "https://github.com/ASVIEST/cproxsuite deps/vendor/cproxsuite"

  when defined(feature.nimproxsuite.linkStatic):
    switch("dynlibOverride", "cproxsuite")

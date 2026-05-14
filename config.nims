task generate, "Generate bindings":
    when not defined(feature.nimproxsuite.gen):
        # atlas install --feature=gen
        raiseAssert "To run bindings generation, install it with gen feature"
    
    setCommand "r", "generator/gen.nim"

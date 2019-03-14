<section> <!-- open concepts -->
## CMake concepts
</section> <!-- close concepts -->

<section> <!-- open configure -->
_configure_ vs _build_

* CMake not actually a _build_ system on its own
* Instead, is used for _configuring_ builds
* Actual building is done by some backend, e.g. Make, Ninja or Visual Studio
* Consequence: When target dependencies change, only _build_ is updated.
  Reconfiguring only happens when CMake files themselves change!

<aside class="notes">
Compare with autotools if anyone cares
</aside>
</section> <!-- close configure -->

<section> <!-- open targets -->
_targets_ vs _properties_ vs _variables_

* A _target_ is something for the buildsystem to produce or run
  (e.g. `add_executable` or `add_library`)
* Targets have _properties_ - for example:
  - C++ standard to compile with
  - Include directories
  - Target dependencies
* _variables_ exist only at _configure_ time, can be used to e.g. conditionally enable or disable targets
  or for configure time logic like setting compiler-dependent build flags
</section> <!-- close targets -->

<section> <!-- open functions -->
_functions_ vs _macros_

* CMake is a procedural scripting language and thus has way to create procedures ("functions")
* In addition, also has macros (i.e. take _this_ piece of code and replace it with _that_ piece of code)
* Sometimes you need to use macros, if not, prefer functions

```
function(hello_function arg)
message("Hello, $${arg}!")
endfunction()
```

</section> <!-- close functions -->

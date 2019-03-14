<section>
## Hello World
</section>

<section>
### Consists of:

* A library that provides text formatting capabilities
* An executable that uses that library

```.
├── app_src
│   └── main.cpp
├── CMakeLists.txt
├── include
│   └── hello
│       └── hello_world.hpp
└── src
    └── hello_world.cpp

```
</section>

<section>
### The Hello World library
```
// include/hello/hello_world.hpp
$snippet("examples/hello-world/include/hello/hello_world.hpp")$
```
```
// src/hello_world.cpp
$snippet("examples/hello-world/src/hello_world.cpp")$
```
</section>

<section>
### The application
```
// app_src/main.cpp
$snippet("examples/hello-world/app_src/main.cpp")$
```
</section>

<section>
### The CMakeLists.txt
```
$snippet("examples/hello-world/CMakeLists.txt")$
```
<aside class="notes">
Pause here, discuss each element line separately
</aside>
</section>

<section>
### Build & run
```
$$ mkdir build
$$ cd build
$$ cmake <path-to-project-dir>
$$ cmake --build .
$$ ./hello-world-exe
```
</section> 

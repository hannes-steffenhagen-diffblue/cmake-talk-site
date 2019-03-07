#include "hello/hello_world.hpp"

#include <sstream>

std::string make_greeting(const std::string &name)
{
  std::ostringstream out;
  out << "Hello, " << name << "!";
  return out.str();
}

// Hey Emacs, this is -*- coding: utf-8 -*-

#include "main.hpp"

#define BOOST_TEST_MODULE HikerTest
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(global_function_example) {
  BOOST_REQUIRE_EQUAL(warp(), 42);
}

// #include <cassert>
// #include <concepts/concepts.hpp>
// #include <iostream>

// auto main(int /*argc*/, char* /*argv*/[]) -> int {
//   // NOLINTNEXTLINE(cppcoreguidelines-pro-bounds-array-to-pointer-decay)
//   assert(warp() == 42);

//   std::cout << "Tests passed!" << std::endl;

//   return 0;
// }

// Hey Emacs, this is -*- coding: utf-8 -*-

#include "main.hpp"

#define BOOST_TEST_MODULE WarpTest
#include <boost/test/unit_test.hpp>

// NOLINTNEXTLINE
BOOST_AUTO_TEST_CASE(warp_test) {
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

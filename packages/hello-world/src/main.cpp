// Hey Emacs, this is -*- coding: utf-8 -*-

#include <cstdint>
#include <iostream>

int main(int argc, char *argv[]) {
  // std::locale loc(std::locale(), new nan_num_put);
  // std::cout.imbue(loc);

  std::uint16_t a = 10;
  std::uint8_t b = a;

  std::cout << "Hello World!" << std::endl;

  return 0;
}

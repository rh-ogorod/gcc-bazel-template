// Hey Emacs, this is -*- coding: utf-8 -*-

#include <iostream>
#include <range/v3/view.hpp>
#include <range/v3/view/join.hpp>
#include <string>
#include <vector>

[[nodiscard]] inline auto buildDiamond(char first, char last, char fill)
    -> std::vector<std::string> {
  using Strings = decltype(buildDiamond(first, last, fill));
  namespace views = ranges::views;

  if (first > last) {
    std::swap(first, last);
  }

  const auto length = last - first + 1;

  auto lines = views::transform(views::iota(0), [&](char32_t idx) {
    const std::array slices{
        std::string(length - idx - 1, fill),
        std::string{static_cast<char>(first + idx)},
        std::string(idx, fill)};

    auto left = slices | views::join;

    auto right = left | views::reverse | views::drop(1);

    return views::concat(left, right) | ranges::to<std::string>();
  });

  auto top = lines | views::take(length);
  auto bottom = top | views::reverse | views::drop(1);
  return views::concat(top, bottom) | ranges::to<Strings>();
}

auto main(int /*argc*/, char* /*argv*/[]) -> int {
  auto diamond = buildDiamond('A', 'E', '.');

  for (const auto& line : diamond) {
    std::cout << line << "\n";
  }

  return 0;
}

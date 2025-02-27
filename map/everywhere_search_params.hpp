#pragma once

#include "map/search_product_info.hpp"

#include "search/result.hpp"

#include <chrono>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <vector>

namespace search
{
struct EverywhereSearchParams
{
  using OnResults =
      std::function<void(Results const & results, std::vector<ProductInfo> const & productInfo)>;

  std::string m_query;
  std::string m_inputLocale;
  std::optional<std::chrono::steady_clock::duration> m_timeout;

  OnResults m_onResults;
};
}  // namespace search

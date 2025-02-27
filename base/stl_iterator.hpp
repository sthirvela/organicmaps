#pragma once

#include <boost/iterator/iterator_facade.hpp>

namespace detail
{
struct Dummy
{
  template <class T> Dummy & operator=(T const &) { return *this; }
};
}

class CounterIterator :
    public boost::iterator_facade<CounterIterator, detail::Dummy, boost::forward_traversal_tag>
{
  size_t m_count;
public:
  CounterIterator() : m_count(0) {}
  size_t GetCount() const { return m_count; }

  detail::Dummy & dereference() const
  {
    static detail::Dummy dummy;
    return dummy;
  }
  void increment() { ++m_count; }
};

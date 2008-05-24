require 'helper'

class LayoutTest < Test::Unit::TestCase

  def setup    ; global_setup    ; end
  def teardown ; global_teardown ; end

  def test_initialize
    # Make sure attributes are cleaned
    layout = Nanoc::Layout.new("content", { 'foo' => 'bar' }, '/foo/')
    assert_equal({ :foo => 'bar' }, layout.attributes)

    # Make sure path is fixed
    layout = Nanoc::Layout.new("content", { 'foo' => 'bar' }, 'foo')
    assert_equal('/foo/', layout.path)
  end

  def test_to_proxy
    # Create layout
    layout = Nanoc::Layout.new("content", { 'foo' => 'bar' }, '/foo/')
    assert_equal({ :foo => 'bar' }, layout.attributes)

    # Create proxy
    layout_proxy = layout.to_proxy

    # Check values
    assert_equal('bar', layout_proxy.foo)
  end

  def test_attribute_named
    # Create layout
    layout = Nanoc::Layout.new("content", { 'foo' => 'bar' }, '/foo/')

    # Check attributes
    assert_equal({ :foo => 'bar' }, layout.attributes)
    assert_equal('bar', layout.attribute_named(:foo))
    assert_equal('erb', layout.attribute_named(:filter))

    # Create layout
    layout = Nanoc::Layout.new("content", { 'filter' => 'bar' }, '/foo/')

    # Check attributes
    assert_equal({ :filter => 'bar' }, layout.attributes)
    assert_equal('bar', layout.attribute_named(:filter))
  end

  def test_filter_class
    # Check existant filter class
    layout = Nanoc::Layout.new("content", { 'filter' => 'erb' }, '/foo/')
    assert_equal(Nanoc::Filters::ERB, layout.filter_class)

    # Check nonexistant filter class
    layout = Nanoc::Layout.new("content", { 'filter' => 'klasdfhl' }, '/foo/')
    assert_equal(nil, layout.filter_class)
  end

end

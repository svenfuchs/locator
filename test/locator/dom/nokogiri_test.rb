require File.expand_path('../../../test_helper', __FILE__)
require 'nokogiri'

class NokogiriTest < Test::Unit::TestCase
  include Locator

  # test "Element takes a Nokogiri dom" do
  #   dom = Nokogiri::HTML::Document.parse('<a href="#">the link</a>')
  #   assert Element.new.locate(dom, 'the link')
  # end

  test "Element takes a Nokogiri page adapter" do
    dom = Locator::Dom::Nokogiri::Page.new('<a href="#">the link</a>')
    assert Element.new.locate(dom, 'the link')
  end
end
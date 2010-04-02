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

  # test "Nokogiri and Umlauts" do
  #   encoded = '<p>&ouml;</p>'
  #   unencoded = '<p>ö</p>'
  #
  #   # this is ok
  #   fragment = Nokogiri::HTML.fragment(encoded)
  #   assert_equal encoded, fragment.to_s
  #
  #   # this seems weird ... wtf experiences ahead
  #   fragment = Nokogiri::HTML.fragment(unencoded)
  #   assert_equal encoded, fragment.to_s
  #
  #   options =
  #     Nokogiri::XML::ParseOptions::RECOVER |
  #     Nokogiri::XML::ParseOptions::NOERROR |
  #     Nokogiri::XML::ParseOptions::NOWARNING
  #
  #   # this is ok
  #   node = Nokogiri::HTML.parse(encoded, nil, nil, options)
  #   assert_equal encoded, node.xpath('//p').first.to_s
  #
  #   # this is ok
  #   node = Nokogiri::HTML.parse(unencoded, nil, 'utf-8', options)
  #   assert_equal unencoded, node.xpath('//p').first.to_s
  # end
end
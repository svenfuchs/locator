require File.expand_path('../../../test_helper', __FILE__)

$: << '~/Development/projects/steam/lib'
begin
  require 'steam'
  include Steam

  Java.load(Dir["#{Steam.config[:html_unit][:java_path]}/*.jar"].join(':'))
  Java.import 'com.gargoylesoftware.htmlunit.WebClient'
  Java.import 'com.gargoylesoftware.htmlunit.BrowserVersion'

  class HtmlunitElementTest < Test::Unit::TestCase
    include Locator, Java::Com::Gargoylesoftware::Htmlunit

    def setup
      connection = Connection::Mock.new
      client = WebClient.new(BrowserVersion.FIREFOX_3)
      client.setWebConnection(Rjb::bind(Browser::HtmlUnit::Connection.new(connection), 'com.gargoylesoftware.htmlunit.WebConnection'))

      connection.mock(:get, 'http://localhost:3000/', '<a href="#" class="foo">the link</a><div id="bar"></div>')
      @dom = Dom::Htmlunit::Page.new(client.getPage('http://localhost:3000/'))
    end

    test "Element takes a Htmlunit::Page adapter" do
      element = Element::Link.new.locate(@dom, 'the link', :class => 'foo')
      assert element.name
    end

    test "responds to name" do
      element = Element::Link.new.locate(@dom, 'the link')
      assert_equal 'a', element.name
    end

    test "responds to xpath" do
      element = Element::Link.new.locate(@dom, 'the link')
      assert_equal '/html/body/a', element.xpath
    end

    test "responds to to_s" do
      element = Element::Link.new.locate(@dom, 'the link')
      assert_equal "<a href=\"#\" class=\"foo\">\n  the link\n</a>\n", element.to_s
    end

    test "responds to content" do
      element = Element::Link.new.locate(@dom, 'the link')
      assert_equal "the link", element.content
    end

    test "responds to attribute" do
      element = Element::Link.new.locate(@dom, 'the link')
      assert_equal 'foo', element.attribute('class')
    end

    test "responds to element_by_id" do
      element = Element.new(:html).locate(@dom)
      assert_equal 'bar', element.element_by_id('bar').attribute('id')
    end

    test "responds to element_by_xpath" do
      element = Element.new(:html).locate(@dom)
      assert_equal 'bar', element.element_by_xpath('//html/body/div[@id="bar"]').attribute('id')
    end
  
    test "responds to elements_by_xpath" do
      element = Element::Link.new.locate(@dom, 'the link')
      assert_equal 'foo', element.attribute('class')
    end

    test "responds to ancestors" do
      element = Element.new(:a).locate(@dom)
      assert_equal %w(html body), element.ancestors.map { |e| e.name }
    end

    test "responds to ancestor_of?" do
      element = Element.new(:a).locate(@dom)
      assert_equal %w(html body), element.ancestors.map { |e| e.name }
    end
  end
rescue LoadError
  puts "skipping HtmlUnit tests because Steam is not available"
end
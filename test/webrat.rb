# encoding: utf-8
require File.expand_path('../test_helper', __FILE__)
require 'action_pack'
require 'webrat'
require 'rack/test'

Webrat.configure do |config|
  config.mode = :rack
end

class WebratBehaviorTest < Test::Unit::TestCase
  include Webrat::Methods
  
  def last_response
    @last_response ||= Rack::Response.new
  end

  def with_html(html)
    last_response.body = html
  end

  test "foo" do
    with_html '<span>München</span>'
    field = field_by_xpath(".//span")
    p field.element.to_s
  end
end
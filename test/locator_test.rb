# require File.expand_path('../test_helper', __FILE__)
# 
# # fills_in 'bla', :with => 'blub'
# # => locate_field('bla')
# # => locate any (inputs with type (text or password) or textarea) and (name 'bla' or id 'bla' or label 'bla')
# 
# class Element
#   attr_reader :name, :attributes
# 
#   def initialize(name, attributes = {})
#     @name = name || '*'
#     @attributes = attributes
#     @terms = attributes.empty? ? ["//#{name}"] : and_("//#{name}", attributes)
#   end
# 
#   def xpath(*args)
#     attributes = args.last.is_a?(Hash) ? args.pop : {}
#     terms(args.pop, attributes).join(" | \n")
#   end
# 
#   def terms(selector, attributes)
#     terms = @terms
#     terms = terms.map { |term| or_(term, {:id => selector, :name => selector}) }.flatten if selector
#     terms.map { |term| and_(term, attributes) }
#   end
# 
#   def or_(path = nil, attributes = {})
#     attributes.map { |name, value| "#{path}[@#{name}=\"#{value}\"]" }
#   end
# 
#   def and_(path = nil, attributes = {})
#     [path + or_('', attributes).join]
#   end
# end
# 
# class FormElement < Element
#   def terms(selector, attributes)
#     super + super(nil, attributes).map do |term|
#       [ "#{term}[@id=//label[contains(.,\"#{selector}\")]/@for]",
#         "//label[contains(.,\"#{selector}\")]#{term}" ]
#     end.flatten
#   end
# 
#   def locatable_attributes
#     ['id', 'name']
#   end
# end
# 
# class Input < FormElement
#   def initialize(attributes = {})
#     super('input', attributes)
#   end
# end
# 
# class Textarea < FormElement
#   def initialize(attributes = {})
#     super('textarea', attributes)
#   end
# end
# 
# class Field
#   def initialize(attributes = {})
#     @elements = [Input.new(attributes.merge(:type => 'text')), Input.new(attributes.merge(:type => 'password')), Textarea.new(attributes)]
#   end
# 
#   def xpath(*args)
#     attributes = args.last.is_a?(Hash) ? args.pop : {}
#     selector = args.pop
# 
#     @elements.map { |element| element.xpath(selector, attributes) }.join(" | \n")
#   end
# end
# 
# class LocatorTest < Test::Unit::TestCase
#   test 'locates fields by selector' do
#     dom = dom('<input type="text" class="foo" /><input type="text" name="foo" /><textarea id="foo"></textarea>')
#     path = Field.new.xpath('foo')
#     elements = dom.elements_by_xpath(path)
# 
#     assert_equal 2, elements.size
#     assert_equal '<input type="text" name="foo">', elements[0].to_s
#     assert_equal '<textarea id="foo"></textarea>', elements[1].to_s
#   end
# 
#   test 'locates field by attribute' do
#     dom = dom('<input type="text" class="foo" /><textarea class="foo" />')
#     path = Field.new.xpath(:type => 'text', :class => 'foo')
#     elements = dom.elements_by_xpath(path)
# 
#     assert_equal 1, elements.size
#     assert_equal '<input type="text" class="foo">', elements.first.to_s
#   end
# 
#   test 'locates an element by label text and attribute' do
#     dom = dom('<label for="bar">foo</label><input type="text" id="bar" class="class" />')
#     path = Field.new.xpath('foo', :class => 'class')
#     assert_equal '<input type="text" id="bar" class="class">', dom.elements_by_xpath(path).first.to_s
# 
#     # puts Field.new.xpath('foo', :class => 'class')
#     # puts
#     # puts Field.new(:class => 'class').xpath('foo')
#   end
# end

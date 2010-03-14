files = Dir[File.dirname(__FILE__) + '/**/*_test.rb']
# files.reject! { |file| file.include?('htmlunit') }

files.each do |filename|
  require filename # unless filename.include?('_locator')
end
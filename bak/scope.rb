my_var = "Hello"
MyClass = Class.new do
  puts my_var
  
  define_method :my_method do
    puts my_var
  end
end

my = MyClass.new
my.my_method
  

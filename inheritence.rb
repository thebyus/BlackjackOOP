class Animal
	attr_accessor :name

	def initialize(name)
		@name = name
	end
	
	def speak
		"animal speaks"
	end
	
	def runs
		"animal runs"
	end
	
end

#Requires "name" getter!	
	module Swimmable
		def swim
			"#{name} is swimming!"
		end
	end

	class Dog < Animal
		include Swimmable
	
		def speak
		"#{name} barks"
		
		end

	end

	class Cat < Animal


	end

fido = Dog.new('fido')

puts fido.speak
puts fido.runs
puts fido.swim

kitty = Cat.new('kitty')
puts kitty.speak
puts kitty.swim
class Dog
	#1. state - instance variables
	#2. behavior - instance methods
	
		attr_accessor :name, :weight, :height
		
		@@count = 0 #class variable
		
			def self.total_dogs
				"There are #{@@count} total objects in the 'Dog' class."
			end
	
	def initialize(n, w, h)
		@name = n
		@weight = w
		@height = h
		@@count += 1
	end
	
	def speak
		"#{name}: bark"
	end
	
	
	def change_everything(n, w, h)
		self.name = n
		self.weight = w
		self.height = h
	end
	
	def get_everything
		"#{name} weighs #{weight} lbs and is #{height} feet tall"
	end
#	def weight
#		@weight
#	end
	
#	def weight=(new_weight)
#		@weight = new_weight
#	end
	
#	def name #getter
#		@name
#	end
		
#	def name=(new_name) # setter
#		@name = new_name
#	end	
	
end

	fido = Dog.new('fido' , 25, 2.1)
	spot = Dog. new('spot' , 50, 2.5)

	puts spot.speak

	puts fido.name
	fido.name = "Carl"
	puts fido.name
	
	puts spot.weight
	spot.weight = 75
	puts spot.weight
	puts
	puts spot.get_everything
	spot.change_everything('Killer', 7, 0.5)
	puts spot.get_everything
	puts
	puts Dog.total_dogs
	
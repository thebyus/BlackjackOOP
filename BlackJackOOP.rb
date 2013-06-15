require 'rubygems'
require 'pry'


class Card
	attr_accessor :suit, :face_value

	def initialize(s, v)
		@suit = s
		@face_value = v
	end
	
	def pretty_output
		"#{face_value} of #{suit_name}"
	end
	
	def to_s
		pretty_output
	end
	
	def suit_name
		case suit
			when 'H' then 'Hearts'
			when 'D' then 'Diamonds'
			when 'S' then 'Spades'
			when 'C' then 'Clubs'
		end
	end
	
end

class Deck
	attr_accessor :cards
	
	def initialize
		@cards =[]
			['H', 'D', 'S', 'C'].each do |suit|
			['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].each do |face_value|
				@cards << Card.new(suit, face_value)
			end
			end
		mix_up
	end
	
	def mix_up
		cards.shuffle!
	end
	
	def deal
		cards.pop
	end
	
	def size
		cards.size
	end
	
end

module Hand

	BLACKJACK_AMOUNT = 21

	def show_hand
		puts " ---#{name}'s Hand---"
		cards.each do |card|
			puts "#{card.to_s}"
		end
		puts "Total: #{total}"
	end
	
	def total
	
		face_values = cards.map{|card| card.face_value}
		total = 0
		
		face_values.each do |val|
			if val == "Ace"
				total +=11
			else
				total += (val.to_i == 0 ? 10 : val.to_i)
			end
		end
		
		face_values.select{|val| val == "Ace"}.count.times do
			break if total <= BLACKJACK_AMOUNT
			total -= 10
		end
		total
	end
	
	def add_card(new_card)
		cards << new_card
	end
	
	def busted?
		total > BLACKJACK_AMOUNT
	end
	
end

class Player
	include Hand
	
	attr_accessor :name, :cards
	
	def initialize(n)
		@name = n
		@cards = []
	end
	
end

class Dealer
	include Hand

	attr_accessor :name, :cards
	
	def initialize
		@name = "Dealer"
		@cards = []
	end
	
	def show_flop
				puts " ---Dealer's Hand---"
				puts "The dealer is showing the #{cards[1]}"

	end
end



class Blackjack
	attr_accessor :deck, :player, :dealer
	
	BLACKJACK_AMOUNT = 21
	DEALER_STAY_MIN = 17

	def initialize
		@deck = Deck.new
		@player = Player.new("Player1")
		@dealer = Dealer.new
	end
	
	def set_player_name
		puts "What's Player1's name?"
		player.name = gets.chomp
	end
	
	def deal_cards
		player.add_card(deck.deal)
		dealer.add_card(deck.deal)
		player.add_card(deck.deal)
		dealer.add_card(deck.deal)
	end
	
	def show_flop
		player.show_hand
		dealer.show_flop
	end
	
	def blackjack_or_bust(player_or_dealer)
		if player_or_dealer.total == BLACKJACK_AMOUNT
			if player_or_dealer.is_a?(Dealer)
				dealer.show_hand
				puts "Sorry, the Dealer hit Blackjack. #{player.name} loses :("
			else
				puts "Blackjack! #{player.name} wins!"
			end
			play_again
		elsif player_or_dealer.busted?
			if player_or_dealer.is_a?(Dealer)
				dealer.show_hand
				puts "The Dealer has busted. #{player.name} Wins!"
			else
				puts "#{player.name} busted! #{player.name} loses :("
			end
			play_again
		end
	end
			
	
	
	
	def player_turn
		puts "#{player.name}'s turn."
		
		blackjack_or_bust(player)
		
		while !player.busted?
			puts "Would #{player.name} like to 'Hit' or 'Stay'?"
			response = gets.chomp
			response = response.downcase
			if !['hit', 'stay'].include?(response)
				puts "Please type the word 'Hit' or the word 'Stay'."
				next
			end
			
			if response == 'stay'
				puts "#{player.name} choose to stay at #{player.total}."
				break
			end
			
			#hit
			new_card = deck.deal
			puts "#{player.name} has been dealt a #{new_card}."
			player.add_card(new_card)
			puts "#{player.name}'s total is now: #{player.total}."

			blackjack_or_bust(player)
		end
	end
		
		def dealer_turn
			puts "It's the Dealer's turn!"
			
			blackjack_or_bust(dealer)
			
			while dealer.total < DEALER_STAY_MIN
				new_card = deck.deal
				puts "Dealer's new card is the #{new_card}."
				dealer.add_card(new_card)
							
				blackjack_or_bust(dealer)
			end
			dealer.show_hand
			puts "The Dealer stays at #{dealer.total}."
		end
	
	
	def who_won(player, dealer)
		if player.total > dealer.total
			puts "Congratulations! #{player.name} wins!"
		elsif player.total < dealer.total
			dealer.show_hand
			puts "The Dealer wins. #{player.name} loses :("
		else
			puts "It's a tie!"
		end
		play_again
	end
	
	def play_again
	puts
	puts "Would you like to play again? Yes or no?"
		if gets.chomp.downcase == 'yes'
			puts "Starting a new game..."
			puts
			deck = Deck.new
			player.cards = []
			dealer.cards = []
			player.name = "Player1"
			start
		else
			puts "Thanks for playing! Goodbye!"
			exit
		end
	end
	
	
	def start
		set_player_name
		deal_cards
		show_flop
		player_turn
		dealer_turn
		who_won(player, dealer)
	end
end


game = Blackjack.new
game.start
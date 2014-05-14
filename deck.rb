#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Deck
  attr_accessor :deck
  attr_accessor :num_decks


  def initialize(decks=1)
    @num_decks = decks
    self.send('generate')
  end

  # Draw 5 cards for a game strip poker
  def deal()
    hand = @deck.pop(5)
    p hand
    if @deck.length() <= 5
      self.send('generate')
    end
    return hand.join(" ")
  end

  # Draw 7 cards for a game of blackjack poker
  def deal2()
    hand = @deck.pop(7)
    p hand
    if @deck.length() <= 7
      self.send('generate')
    end
    return hand.join(" ")
  end

    def draw1()
        hand = @deck.pop(1)
        p hand
        if @deck.length() <= 5
           self.send('generate')
        end
        return hand.join(" ")
  end
 
    def draw2()
        hand = @deck.pop(2)
        p hand
        if @deck.length() <= 5
           self.send('generate')
        end
        return hand.join(" ")
  end
 
    def draw3()
        hand = @deck.pop(3)
        p hand
        if @deck.length() <= 5
           self.send('generate')
        end
        return hand.join(" ")
  end

    def draw4()
        hand = @deck.pop(4)
        p hand
        if @deck.length() <= 5
           self.send('generate')
        end
        return hand.join(" ")
  end


  def generate()
    @deck = Array.new()
    @num_decks.times { |i|
      ['[color=grey]♣[/color]', '[color=black]♠[/color]', '[color=red]♥[/color]', '[color=blue]♦[/color]'].each do |suit|
        %w{A 2 3 4 5 6 7 8 9 10  J Q K }.each do |rank|
          @deck << "#{rank}#{suit}"
        end
      end
    }
    @deck.shuffle!
    p @deck
  end

end
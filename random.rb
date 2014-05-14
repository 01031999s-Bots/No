#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Random
  attr_accessor :randoms
  attr_accessor :random


  def initialize(randoms=1)
    @randoms = randoms
    self.send('generate')
  end
 
#decides on a sentence to 'draw' from the 'deck' XD
    def deal()
        hand = @random.pop(1)
        p hand
        if @random.length() <= 5
           self.send('generate')
        end
        return hand.join(" ")
  end

  def generate()
    @random = Array.new()
    @randoms.times { |i|
      ['shoots a rocket launcher at', 'takes a big trout and slaps', 'tosses a giant m&m at', 'shoots a minigun at', 'grabs and snuggles up to', 'realeses a bunch of zombies which attack', 'realeses a bunch of attack dogs which chase', 'animates a sword which chases'].each do |random|
#there are 7 sentences to generate from...update to 10 later.
          @random << "#{random}"
      end
    }
    @random.shuffle!
    p @random
  end
end
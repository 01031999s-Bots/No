#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
$:.push File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'pokerbot'
require 'yaml'
require './random.rb'
require './deck.rb'
require './monsterize.rb'

bot = Pokerbot.new("Pokerbot by Jippen Faddoul ( http://github.com/jippen/fchat_pokerbot_ruby )","1.1")
config = YAML.load_file('pokerbot.yaml')

bot.deck = Deck.new()
bot.random = Random.new()
bot.monsterize = Monsterize.new()
bot.login(config['server'],config['username'],config['password'],config['character'])

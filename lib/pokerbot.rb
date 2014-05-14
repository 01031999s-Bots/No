#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
 
require 'libfchat/fchat'
require 'yaml'
require './deck.rb'
require './random.rb'
require './monsterize.rb'

class Pokerbot < Libfchat::Fchat
  attr_accessor :random
  attr_accessor :deck
  attr_accessor :monsterize
  attr_reader :users
  attr_reader :ops
  attr_reader :rooms
  
  # Join chatrooms on invite
  def got_CIU(message)
    #Annoyingly, the json for this varies for public and private rooms.
    #So just try both and call it a day.
    self.send('JCH',message['name'])
    self.send('JCH',message['channel'])
  end
 
  # Respond to private messages
  def got_PRI(message)
p "-Helping out a person. XD-"
if message['message'].downcase =~ /^help/
msg = "Three active command for this bot and that is !random ['player'], !deal ['player'], and !monsterize ['player']."
      self.send('PRI',message['character'],msg)
sleep(1)
    end
  end

#everything else

    def MSG(channel,message)
      json = {:channel => channel,
              :message => message }
      self.send_message('MSG',json)
    end
    
    def OPP()
      self.send_message('OPP',{})
    end
    
    def got_JCH(message)
      begin
        @rooms[message['channel']]['characters'].push(message['character']['identity'])
      rescue
        @rooms[message['channel']] = {
          'title'       => message['title'],
          'description' => '',
          'characters'  => [],
          'ops'         => [],
        }
      end
    end
    
    def got_COL(message)
      @rooms[message['channel']]['ops'] = message['oplist']
    end

    def got_ADL(message)
      @ops = message['ops']
    end
    
    def send_message(type, json)
      jsonstr = ::MultiJson.dump(json)
      msg = "#{type} #{jsonstr}"
      if type == 'IDN'
        json[:ticket] = '[REDACTED]'
      end
      filteredjsonstr = ::MultiJson.dump(json)
      @logger.debug(">> #{type} #{filteredjsonstr}")
      @websocket.send(msg)
    end
    
        def parse_message(msg)
      type = msg[0,3]
      begin
        data = MultiJson.load(msg[4..-1])
      rescue
        data = MultiJson.load('{}')
      end

      @logger.debug("<< #{msg}")

      begin
        self.send("got_#{type}",data)
      rescue
      end
    end
    
        def method_missing(method_name, *args, &block)
      # Try to handle all three-letter strings
      if method_name.to_s[4,7] =~ /[A-Z]{3}/
        return nil
      else
        super(method_name,*args,&block)
      end
    end
    
        def got_LIS(message)
      message['characters'].each do |character|
        @users[character[0]] = {
          'gender'  => character[1],
          'status'  => character[2],
          'message' => character[3]
        }
      end
    end
    
	def got_ICH(message)
      message['users'].each do |user|
        @rooms[message['channel']]['characters'].push(user['identity'])
      end
    end
    
        def CIU(channel,character)
      json = {:channel   => channel,
              :character => character }
      self.send_message('CIU',json)
    end
    
        def COL(channel)
      json = {:channel => channel }
      self.send_message('COL',json)
    end
    
    
  # Respond to messages in chatrooms
  def got_MSG(message)
    p "-I got a message! YAY!-"
    chara = message['character']
if message['message'].downcase =~ /^!random (.*)?/i
msglist = message['message'].split(/random (.*)?/i)
msg = "/me " + @random.deal() + " " + msglist[1] + "!"
      self.send('MSG',message['channel'],msg)
      sleep(1)
elsif message['message'].downcase =~ /^!deal (.*)?/i
msglist = message['message'].split(/deal (.*)?/i)
msg = msglist[1] + ": " + @deck.deal()
      self.send('MSG',message['channel'],msg)
           sleep(1)
elsif message['message'].downcase =~ /^!monsterize/
msg = "/me shoots a beam of light at "+ message['character'] + " turning them into a " + @monsterize.deal()
      self.send('MSG',message['channel'],msg)
           sleep(1)
elsif message['message'].downcase =~ /^!invite (.*)?/i
msglist = message['message'].split(/invite (.*)?/i)
msg = @CIU + msglist[1]
      self.send('CIU',msglist[1],msg)
           sleep(1)
      elsif message['message'] =~ /^!deal/
	      msg = message['character'] + ": " + @deck.deal()
        self.send('MSG',message['channel'],msg)
	sleep(1)
	elsif message['message'].downcase =~ /^!desc/
		msg = @rooms[message['channel']]['characters'].push(message['character']['identity'])
      self.send('MSG',message['channel'],msg)
      sleep(1)
end
end
end
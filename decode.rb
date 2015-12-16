#!/usr/bin/ruby

#Modules require
require 'rubygems'
require 'deathbycaptcha'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

url = ""

browser = Selenium::WebDriver.for :firefox
browser.get url
page = Nokogiri::HTML(browser.page_source)
image =page.css("#recaptcha_challenge_image").attr('src')

client = DeathByCaptcha.new(ENV["KEY_USER"], ENV["KEY_PASS"], :http)
captcha = client.decode!(url: image)
puts "El texto del captcha es: #{captcha.text}"

  if captcha.is_correct
    puts "Success"
  else
    puts "Retry"
  end

browser.quit();

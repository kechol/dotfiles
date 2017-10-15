#!/usr/bin/ruby

# <bitbar.title>JPYBTC rate at coincheck</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Kazuyuki Suzuki</bitbar.author>
# <bitbar.author.github>kechol</bitbar.author.github>
# <bitbar.desc>Gets current JPYBTC rate from coincheck public API.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://coincheck.com/ja/documents/exchange/api#ticker</bitbar.abouturl>

require "open-uri"
require "json"
require "date"

open("https://coincheck.com/api/ticker.json") do |file|
  json = JSON.load(file)
  puts "₿ #{json['last']}"

  puts "---"

  puts "Last:   #{json['last']}"
  puts "Bid:    #{json['bid']}"
  puts "Ask:    #{json['ask']}"
  puts "High:   #{json['high']}"
  puts "Low:    #{json['low']}"
  puts "Volume: #{json['volume']}"
  puts Time.at(json['timestamp']).to_datetime
end

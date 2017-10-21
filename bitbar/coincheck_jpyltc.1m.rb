#!/usr/bin/ruby

# <bitbar.title>LTC/JPY rate at coincheck</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Kazuyuki Suzuki</bitbar.author>
# <bitbar.author.github>kechol</bitbar.author.github>
# <bitbar.desc>Gets current LTC/JPY rate from coincheck public API.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://coincheck.com/ja/documents/exchange/api#buy-rate</bitbar.abouturl>

require "open-uri"
require "json"

open("https://coincheck.com/api/rate/ltc_jpy") do |file|
  json = JSON.load(file)
  puts "Ł#{format('%.1f', json['rate'].to_f)}"
  puts "---"
  puts "Open LTC/JPY Chart | href=https://cc.minkabu.jp/pair/LTC_JPY"
end

#!/usr/bin/ruby

# <bitbar.title>BTC/JPY rate at coincheck</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Kazuyuki Suzuki</bitbar.author>
# <bitbar.author.github>kechol</bitbar.author.github>
# <bitbar.desc>Gets current BTC/JPY rate from coincheck public API.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://coincheck.com/ja/documents/exchange/api#buy-rate</bitbar.abouturl>

require "open-uri"
require "json"

open("https://coincheck.com/api/rate/btc_jpy") do |file|
  jpybtc = JSON.load(file)["rate"].to_f
  puts "₿%.1f" % jpybtc
  puts "---"
  puts "Open JPY/BTC Chart | href=https://cc.minkabu.jp/pair/BTC_JPY"
end

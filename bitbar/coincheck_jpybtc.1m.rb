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

URL_FORMAT = "https://coincheck.com/api/rate/%s"

open(URL_FORMAT % "bch_jpy") do |f_jpybch|
  open(URL_FORMAT % "btc_jpy") do |f_jpybtc|
    jpybch = JSON.load(f_jpybch)["rate"].to_f
    jpybtc = JSON.load(f_jpybtc)["rate"].to_f

    puts "₿%.1f (%.2f)" % [jpybtc, jpybtc / jpybch]
    puts "---"
    puts "Open JPY/BTC Chart | href=https://cc.minkabu.jp/pair/BTC_JPY"
  end
end

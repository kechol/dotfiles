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

URL_FORMAT = "https://coincheck.com/api/rate/%s"

open(URL_FORMAT % "ltc_jpy") do |f_jpyltc|
  open(URL_FORMAT % "btc_jpy") do |f_jpybtc|
    jpyltc = JSON.load(f_jpyltc)["rate"].to_f
    jpybtc = JSON.load(f_jpybtc)["rate"].to_f

    puts "Ł%.1f (%.2f)" % [jpyltc, jpybtc / jpyltc]
    puts "---"
    puts "Open LTC/JPY Chart | href=https://cc.minkabu.jp/pair/LTC_JPY"
  end
end

#!/usr/bin/ruby

# <bitbar.title>NI225 price from Google Finance</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Kazuyuki Suzuki</bitbar.author>
# <bitbar.author.github>kechol</bitbar.author.github>
# <bitbar.desc>Gets current NI225 price from Google Finance API.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://finance.google.com/finance?q=NI225</bitbar.abouturl>

require "open-uri"

URL_FORMAT = "https://finance.google.com/finance/getprices?q=%s&i=300&p=5m&f=c"

open(URL_FORMAT % "NI225") do |f_ni225|
  open(URL_FORMAT % "USDJPY") do |f_usdjpy|
    ni225  = f_ni225.readlines.last.strip.to_f
    usdjpy = f_usdjpy.readlines.last.strip.to_f

    puts "¥%.1f (%.2f)" % [ni225, usdjpy]
    puts "---"
    puts "Open NI225 Chart | href=https://www.nikkei.com/markets/worldidx/chart/nk225/"
    puts "Open USDJPY Chart | href=https://www.nikkei.com/markets/kawase/"
  end
end

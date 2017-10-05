#!/usr/bin/env ruby
require 'json'

cson = []
del  = '/'

begin
  ghqlist = `ghq list --full-path`
  ghqroot = File.expand_path(`git config --get ghq.root` || '~/.ghq').strip
rescue => e
  exit 1
end

ghqlist.split("\n").each do |path|
  title = path.gsub(ghqroot, '').split(del)[2..-1].join(del)
  cson << { title: title, paths: [path] }
end

puts JSON.pretty_generate(cson)

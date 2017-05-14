Pry.config.pager = false

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

begin
  require "awesome_print"
  AwesomePrint.pry!
rescue LoadError
  # Missing goodies, bummer
end

begin
  require 'hirb'
  Hirb.enable
rescue LoadError
  # Missing goodies, bummer
end

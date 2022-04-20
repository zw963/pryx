require 'awesome_print'

AwesomePrint.defaults = {
  index: false
}

if defined? AwesomePrint
  if defined? Pry
    require 'pry'
    AwesomePrint.pry!
  else
    require 'irb'
    AwesomePrint.irb!
  end
end

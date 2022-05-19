require 'awesome_print'

# AwesomePrint.defaults = {
#   index: false
# }

if defined? AwesomePrint
  if defined? Pry
    AwesomePrint.pry!
  else
    AwesomePrint.irb!
  end
end

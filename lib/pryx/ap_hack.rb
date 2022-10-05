require 'awesome_print'

# AwesomePrint.defaults = {
#   index: false
# }

if defined? AwesomePrint
  if defined? Pry
    AwesomePrint.pry!
  else
    # auto ap only works when running with `irbx`
    AwesomePrint.irb!
  end
end

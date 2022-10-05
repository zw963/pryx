require 'awesome_print'

# AwesomePrint.defaults = {
#   index: false
# }

if defined? AwesomePrint
  AwesomePrint.pry! if defined? Pry

  # auto ap only works when running with `irbx`
  AwesomePrint.irb!
end

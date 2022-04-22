require 'binding_of_caller'

class Binding
  def _irb(_host=nil)
    warn '[1m[33mloading irb ...[0m'

    if defined? Break and defined? IRB
      # This is need for work with looksee better.
      # See discuss on https://github.com/oggy/looksee/issues/57
      IRB.conf[:USE_COLORIZE] = false
    else
      warn "For work with Break and Looksee, please set
export RUBYOPT='-rpryx_irb'
instead of
export RUBYOPT='-rpryx'
"
    end

    self.irb
  end
end

module Kernel
  def irb!
    return unless ENV['IRB_was_started'].nil?

    ENV['IRB_was_started'] = 'true'

    binding.of_caller(1)._irb
  end

  def reirb!
    ENV['IRB_was_started'] = nil
  end

  def irb1
    ENV['IRB2_should_start'] = 'true'
  end

  def irb2(caller=1, remote: nil, port: 9876)
    if ENV['IRB2_should_start'] == 'true'
      ENV['IRB2_should_start'] = nil
      binding.of_caller(caller)._irb
    end
  end
end

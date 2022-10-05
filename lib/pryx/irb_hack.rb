class Binding
  def _irb(_host=nil)
    warn '[1m[33mloading irb ...[0m'

    require 'pryx/common_plugins'

    self.irb
  end
end

module Kernel
  def irb!
    return unless ENV['IRB_was_started'].nil?

    ENV['IRB_was_started'] = 'true'

    irb3(2)
  end

  def reirb!
    ENV['IRB_was_started'] = nil
  end

  def irb1
    ENV['IRB2_should_start'] = 'true'
  end

  def irb2
    if ENV['IRB2_should_start'] == 'true'
      ENV['IRB2_should_start'] = nil
      irb3(2)
    end
  end

  def irb3(caller=1)
    require 'binding_of_caller'

    binding.of_caller(caller)._irb
  end
end

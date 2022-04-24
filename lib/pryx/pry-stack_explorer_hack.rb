module PryStackExplorer
  module FrameManagerHack
    def initialize(bindings, _pry)
      super
      self.bindings = bindings.reject do |b|
        b.source_location[0].match? %r{/pryx/pry_hack.rb}
      end
    end
  end

  FrameManager.prepend FrameManagerHack
end

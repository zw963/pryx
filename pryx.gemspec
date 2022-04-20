name = "pryx"
require File.expand_path("../lib/#{name}/version", __FILE__)

Gem::Specification.new do |s|
  s.name                        = name
  s.version                     = Pryx::VERSION
  s.date                        = Time.now.strftime('%F')
  s.required_ruby_version       = '>= 2.2.2'
  s.authors                     = ['Billy.Zheng(zw963)']
  s.email                       = ['vil963@gmail.com']
  s.summary                     = ''
  s.description                 = ''
  s.homepage                    = 'http://github.com/zw963/pryx'
  s.license                     = 'MIT'
  s.require_paths               = ['lib']
  s.files                       = `git ls-files bin lib *.md LICENSE`.split("\n")
  s.files                      -= Dir['images/*.png']
  s.executables                 = `git ls-files -- bin/*`.split("\n").map {|f| File.basename(f) }

  s.add_runtime_dependency 'pry', '~>0.14'
  s.add_runtime_dependency 'pry-power_assert', '~>0.0.2'
  s.add_runtime_dependency 'pry-doc'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'ritual', '~>0.4'
end

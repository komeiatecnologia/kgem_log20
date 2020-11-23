require 'lib/version'

Gem::Specification.new do |s|
  s.name        = "kgem_log"
  s.version     = KLog::VERSION
  s.description = "Gem genérica para gerar log"
  s.summary     = "Log"
  s.author      = "Komeia Interativa"
  s.files       = Dir["{lib/**/*.rb,*.gemspec, README}"]

  # s.add_dependency "logger"

  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
end

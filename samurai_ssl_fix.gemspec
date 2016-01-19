# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'samurai_ssl_fix'
  s.version     = '0.1.0'
  s.date        = '2012-12-05'
  s.summary     = "Fixes Ruby 1.8.7 / OpenSSL 1.0.1 / Ubuntu 12.04 LTS / Samurai compatibility issue"
  s.description = File.read('README.md')
  s.authors     = ["Drew Blas"]
  s.email       = 'drew.blas@gmail.com'
  s.files       = Dir.glob("{lib}/**/*") + %w(LICENSE README.md TESTING.md samurai_ssl_fix.gemspec)
  s.require_path = 'lib'
  s.homepage    = 'http://rubygems.org/gems/samurai_ssl_fix'

  s.add_dependency "activeresource", "~> 4.0.0"
  s.add_dependency "activesupport", "~> 4.0.13"
end

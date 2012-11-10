$:.unshift File.expand_path('../lib', __FILE__)
require 'genetic_algorithms/version'

Gem::Specification.new do |s|
  s.name        = 'genetic_algorithms'
  s.version     = GeneticAlgorithms::VERSION
  s.authors     = ["Alexander Vanadio"]
  s.email       = 'execdd17@gmail.com'
  s.homepage    = 'https://github.com/execdd17/genetic_algorithms'
  s.summary     = "A simple API for using genetic algorithms in Ruby"
  s.description = "This gem allows you to evolve chromosomes in order to solve problems"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("logging", "~> 1.8.0")
  s.add_development_dependency("rspec")
  s.add_development_dependency("simplecov")
end

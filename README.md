[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/execdd17/genetic_algorithms) [![Travis](https://secure.travis-ci.org/execdd17/genetic_algorithms.png)](http://travis-ci.org)

## Description

This project contains my work in progress on Genetic Algorithms. The basic premise involves creating an initial random population of chromosomes and evolving them until they reach some ideal state.

A chromosome is a solution to a problem, and represented as a bit string. It is intentionally general in order to lend itself to multiple domains. The only thing linking it to a particular problem set is the fitness function. A fitness function evaluates a chromosome, that is, the effectiveness of a proposed solution.

## Usage

In my GeneticAlgorithms project, I use the Engine class to encapsulate the entire evolution process. You can quickly use it with default values like this:

```ruby
GeneticAlgorithms::Engine.new.start "AllOffSample"
```

This will return a Hash containing the best chromosome found, and its score based on the fitness function. The argument to the start method is the name of a fitness function module. I have included a few with this project as a basic reference for creating your own. Here is an example fitness function where the best solution is where all bits are off:

```ruby
lambda do |chromosome|
  chromosome.each_char.inject(0) do |accum, char|
    accum += 1 if char == Chromosome::OFF
    accum
  end
end
```

The engine has three optional parameters that can be utilized during construction. The population size, chromosome length, and number of generations to evolve (in that order). You'll notice that modifying these values can have a tremendous effect on the algorithm itself, and that is one of the interesting characteristics of genetic algorithms. In the future I will be opening up more parameters as well; currently many of them are tightly coupled to their respective classes.

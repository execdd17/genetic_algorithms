[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/execdd17/genetic_algorithms) [![Travis](https://secure.travis-ci.org/execdd17/genetic_algorithms.png)](http://travis-ci.org)

## Description

This project contains my work in progress on Genetic Algorithms. The basic premise involves creating an initial random population of chromosomes and evolving them until they reach some ideal state.

A chromosome is a solution to a problem, and represented as a bit string. It is intentionally general in order to lend itself to multiple domains. The only thing linking it to a particular problem set is the fitness function. A fitness function evaluates a chromosome, that is, the effectiveness of a proposed solution.

## The Engine

In the GeneticAlgorithms module, the Engine class encapsulates the entire evolution process. When you construct one, by default it gives you a population of size 10, a chromosome length of 10, and 5 generations of evolution. You'll notice that modifying these values can have a tremendous effect on the algorithm itself, and that is one of the interesting characteristics of Genetic Algorithms. In the future I will be opening up more parameters as well; currently many of them are tightly coupled to their respective classes.

## Knapsack, An Example Use Case

I stumbled on an interesting use case and decided to implement it for demonstrational purposes. Let's say we have a knapsack, and furthermore, let's say it can only hold a finite number of items. Assuming we know how much space each item takes, and how much total space the knapsack has, then how can we most efficiently utilize the knapsack? That is, we want to put as many items in it as possible with the least amount of free space left over. Enter genetic algorithms.

### Encoding

First of all, we need a way to express solutions to this problem as a chromosome. Since genetic_algorithms uses binary encoding, that's how we're going to approach it. Let's decide that there are only 4 items that we're considering for this exclusive knapsack. The items are a hammer, coin, pen, and wallet. The chromosome will then have 4 bits. An "ON" bit indicates that the item is in the knapsack, and an "OFF" means it is not. So, if we see something like "1010" that means a hammer(left one) and pen(right one) are in the knapsack, but the coin(left zero) and wallet(right zero) are not.

### The Fitness Function

From a high level perspective, the fitness function should return how efficient the knapsack is being utilized. The implementation is covered below.

Currently, genetic_algorithms is expecting better solutions to return greater numbers than worse solutions. This implies that the highest number returned from a fitness function is the best solution.

### Finally...some code!

Here is the Knapsack class:

```ruby
class Knapsack
  CAPACITY, BEST_SCORE = 24, 1000

  def initialize chromosome
    @contents = decode chromosome
  end

  def utilization
    space_used = @contents.inject(0) do |accum, item|
      accum += item.space_needed
    end
    
    (space_used.to_f / CAPACITY * 1000).round
  end

  private

  def decode chromosome
    all_items = Item.create_items({ hammer: 17, coin: 4, pen: 9, wallet: 11 })
    index = -1

    filtered_items = all_items.select do |item|
      index += 1
      chromosome[index] == "1"
    end
  end
end
```

And the Item class:

```ruby
class Item
  def self.create_items item_hash
    item_hash.inject(Array.new) do |items, (name, space_needed)|
      items << Item.new(name, space_needed)
    end
  end

  def initialize name, space_needed
    @name = name
    @space_needed = space_needed
  end

  attr_reader :name, :space_needed
end
```

### Enter genetic_algorithms

```ruby
require 'genetic_algorithms'
include GeneticAlgorithms

Engine.configure do |config|
    config.population_size = 10
    config.chromosome_length = 4
end

Engine.new.start(Knapsack::BEST_SCORE) do |chromosome|
  score = Knapsack.new(chromosome).utilization

  if score > Knapsack::BEST_SCORE
    score = Knapsack::BEST_SCORE - (score - Knapsack::BEST_SCORE) 
  end

  score
end
```

Take note of the line checking whether the score is greater than the best score. It is necessary because we don't want genetic_algorithms to think that the over-utilized knapsacks are better solutions. A knapsack with too much stuff in it would otherwise have a higher score. I will be adding a feature so that the user can specify that lower return values from a fitness function are better than higher ones. The fitness function above will be cleaner once that is done. 

The result of this run will be something like:

```ruby
{"1100"=>875}
```

We see here that the best solution found is a hammer and a coin, totalling 21 out of 24 (0.875) in terms of knapsack capacity.

### Um, that's not the best solution...

You are correct! That's why I chose to show it. The best solution is actually "0111", but given the parameters that we used for the engine, it wasn't able to discover it. This illustrates an important point. Genetic Algorithms may not find the best solution, in fact, some people refer to them as "good enough" algorithms. 

You will get the best solution if you run it a few times as shown, but if you tweak the engine parameters a bit, the ideal solution will be found every time.

## Logging

The RouletteWheel, Population, and Chromosome classes have independent loggers. Currently, they are all showing debug level and above messages, and can be changed in lib/genetic_algorithms.rb. The output of the log is written in the root directory titled 'results.log'. It will display things like which chromosomes were chosen to mate, what happened in crossover and mutation, the highest score in a given population, etc. I plan to make the loggers more easily configurable in future releases.

## Feedback

If you have a questions, comments, or feature requests, please feel free to contact me.

# Pipewrench

[![Gem Version](https://badge.fury.io/rb/pipewrench.svg)](https://badge.fury.io/rb/pipewrench)
[![Build Status](https://travis-ci.org/sionide21/pipewrench.svg?branch=master)](https://travis-ci.org/sionide21/pipewrench)

General purpose command line pipe processing tool.

## Installation

    $ gem install pipewrench

## Usage

```
Usage: pipewrench [options] expression
    -c, --compact                    Remove nil lines from output
    -m, --map                        Run each line through the expression
    -s, --strip                      Strip trailing whitespace from each line before running
    -h, --help                       Show this message
        --version                    Show version
```

Pipewrench evaluates the given expression against standard input.
This allows you to write powerful ruby expressions as part of your pipeline.

Here are some examples:

```
# Given a list of integers, add them up
$ seq 1 10 | pipewrench 'map(&:to_i).inject(:+)'
55

# Extract regex from matching lines
$ echo "My Cat" >> pipewrench.txt
$ echo "His Dog" >> pipewrench.txt
$ echo "Her Fish" >> pipewrench.txt
$ echo "My Frog" >> pipewrench.txt
$ cat pipewrench.txt | pipewrench 'grep(/^My (\w+)/) {$1}'
Cat
Frog
```

### -m, --map

Evaluate the expression for each line of input.

```
# Convert input to upper case
$ cat pipewrench.txt | pipewrench -m upcase
MY CAT
HIS DOG
HER FISH
MY FROG
```

### -c, --compact

Remove nils from the output. This is primarily useful in conjunction with `--map` but can be used on its own as well.

```
# Only show lines less than 5
$ seq 1 10 | pipewrench -c -m 'self if to_i < 5'
1
2
3
4
```

### -r, --rails

Load [Active Support Core Extensions](http://guides.rubyonrails.org/active_support_core_extensions.html). This gives you access to rails helper methods.

```
# Convert numbers to human readable sizes
$ echo 100000000 | pipewrench -mr 'to_i.to_s(:human_size)'
95.4 MB
```

### -s, --strip

Remove trailing whitespace from each line before evaluating the expression.

```
# Join a list of numbers as a comma separated list
$ seq 1 10 | pipewrench -s 'join(", ")'
1, 2, 3, 4, 5, 6, 7, 8, 9, 10
```

## Development

After checking out the repo, run `rake rspec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sionide21/pipewrench.

require "optparse"
require "pipewrench/version"

class Pipewrench
  class Options
    attr_reader :map, :strip, :compact, :rails

    def parse!(*args)
      parser.parse!(*args)
      self
    rescue OptionParser::InvalidOption => e
      puts e
      help
    end

    def to_s
      parser.to_s
    end

    def help
      puts self
      exit
    end

    private

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: pipewrench [options] expression [file ...]"

        opts.on("-c", "--compact", "Remove nil lines from output") do |m|
          @compact = true
        end

        opts.on("-m", "--map", "Run each line through the expression") do |m|
          @map = true
        end

        opts.on("-r", "--rails", "Load Active Support Core Extensions") do |m|
          @rails = true
        end

        opts.on("-s", "--strip", "Strip trailing whitespace from each line before running") do |m|
          @strip = true
        end

        opts.on_tail("-h", "--help", "Show this message") do
          help
        end

        opts.on_tail("--version", "Show version") do
          puts "Pipewrench #{Pipewrench::VERSION}"
          exit
        end
      end
    end
  end
end

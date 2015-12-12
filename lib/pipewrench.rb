require "pipewrench/version"
require "pipewrench/options"

class Pipewrench
  attr_reader :options
  include Enumerable

  def initialize(stdin, options=Options.new)
    @stdin = stdin
    @options = options
  end

  def run(cmd)
    if options.compact
      evaluate(cmd).compact
    else
      evaluate(cmd)
    end
  end

  def evaluate(cmd)
    if options.map
      map { |line| line.instance_eval(cmd) }
    else
      to_a.instance_eval(cmd)
    end
  end

  def each(&blk)
    if options.strip
      @stdin.each_line.map(&:rstrip).map(&blk)
    else
      @stdin.each_line(&blk)
    end
  end
end

require "pipewrench/version"

module Pipewrench
  class Shell
    include Enumerable

    def initialize(stdin)
      @stdin = stdin
    end

    def run(cmd)
      instance_eval(cmd)
    end

    def each(&blk)
      @stdin.each_line(&blk)
    end
  end
end

require 'spec_helper'
require 'ostruct'

describe Pipewrench do
  let(:options) { OpenStruct.new }
  let(:pipewrench) { Pipewrench.new("Hello\nWorld\n", options) }

  it "evaluates a ruby expression within the context of the input lines" do
    expect(Pipewrench.new("Hello\nWorld").run("length")).to eq(2)
  end

  context "with --strip" do
    let(:options) { OpenStruct.new(strip: true) }

    it "removes trailing whitespace from each line" do
      expect(pipewrench.run("to_a")).to eq(["Hello", "World"])
    end
  end

  context "with --map" do
    let(:options) { OpenStruct.new(map: true) }

    it "processes line by line" do
      expect(pipewrench.run("upcase")).to eq(["HELLO\n", "WORLD\n"])
    end

    context "with --strip" do
      let(:options) { OpenStruct.new(map: true, strip: true) }

      it "removes trailing whitespace from each line" do
        expect(pipewrench.run("upcase")).to eq(["HELLO", "WORLD"])
      end
    end

    context "with --compact" do
      let(:options) { OpenStruct.new(map: true, compact: true) }

      it "exclude nil lines from the result" do
        expect(pipewrench.run("self if self =~ /H/ ")).to eq(["Hello\n"])
      end
    end
  end

  context "with --rails" do
    let(:options) { OpenStruct.new(rails: true) }

    it "adds active support methods" do
      expect(pipewrench.run("second")).to eq("World\n")
    end
  end
end

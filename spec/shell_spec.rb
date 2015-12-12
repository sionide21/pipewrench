require 'spec_helper'

describe "Examples" do
  def run(cmd)
    `#{cmd.sub("pipewrench", "bundle exec ruby exe/pipewrench")}`
  end

  it "adds up a list of integers" do
    expect(run("seq 1 10 | pipewrench 'map(&:to_i).inject(:+)'")).to eq("55\n")
  end

  it "extracts regex from matching lines" do
    cmd = "echo \"My Cat\nHis Dog\nHer Fish\nMy Frog\n\" | pipewrench 'grep(/^My (\\w+)/) {$1}'"
    expect(run(cmd)).to eq("Cat\nFrog\n")
  end

  it "coverts input to upper case" do
    expect(run("echo \"Hello\nWorld\" | pipewrench -m upcase")).to eq("HELLO\nWORLD\n")
  end

  it "only show lines less than 5" do
    expect(run("seq 1 10 | pipewrench -c -m 'self if to_i < 5'")).to eq("1\n2\n3\n4\n")
  end

  it "joins a list of numbers as a comma separated list" do
    expect(run("seq 1 10 | pipewrench -s 'join(\", \")'")).to eq("1, 2, 3, 4, 5, 6, 7, 8, 9, 10\n")
  end
end

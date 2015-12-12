require 'spec_helper'
require 'tempfile'

describe "Examples" do
  def run(cmd)
    `#{cmd.sub("pipewrench", "bundle exec ruby exe/pipewrench")}`
  end

  def test_file
    @test_file ||= Tempfile.open("spec") do |f|
      f.write("My Cat\nHis Dog\nHer Fish\nMy Frog\n")
      f.path
    end
  end

  it "adds up a list of integers" do
    expect(run("seq 1 10 | pipewrench 'map(&:to_i).inject(:+)'")).to eq("55\n")
  end

  it "extracts regex from matching lines in a file" do
    cmd = "pipewrench 'grep(/^My (\\w+)/) {$1}' #{test_file}"
    expect(run(cmd)).to eq("Cat\nFrog\n")
  end

  it "extracts regex from matching standard in lines" do
    cmd = "echo \"My Cat\nHis Dog\nHer Fish\nMy Frog\n\" | pipewrench 'grep(/^My (\\w+)/) {$1}'"
    expect(run(cmd)).to eq("Cat\nFrog\n")
  end

  it "coverts input to upper case" do
    expect(run("pipewrench -m upcase #{test_file}")).to eq("MY CAT\nHIS DOG\nHER FISH\nMY FROG\n")
  end

  it "only show lines less than 5" do
    expect(run("seq 1 10 | pipewrench -c -m 'self if to_i < 5'")).to eq("1\n2\n3\n4\n")
  end

  it "joins a list of numbers as a comma separated list" do
    expect(run("seq 1 10 | pipewrench -s 'join(\", \")'")).to eq("1, 2, 3, 4, 5, 6, 7, 8, 9, 10\n")
  end

  it "converts numbers to human readable sizes" do
    expect(run("echo 100000000 | pipewrench -mr 'to_i.to_s(:human_size)'")).to eq("95.4 MB\n")
  end
end

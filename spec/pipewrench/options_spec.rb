require 'spec_helper'

describe Pipewrench::Options do
  let(:options) { Pipewrench::Options.new }

  it 'defaults all options to false' do
    expect(options.map).to be_falsey
    expect(options.compact).to be_falsey
    expect(options.strip).to be_falsey
  end

  it "leaves argv with the expression" do
    argv = ["-m", "-s", "-c", "test"]
    options.parse!(argv)
    expect(argv).to eq(["test"])
  end

  it "sets map" do
    argv = ["-m", "test"]
    options.parse!(argv)
    expect(options.map).to be_truthy
    expect(options.compact).to be_falsey
    expect(options.strip).to be_falsey
  end

  it "sets compact" do
    argv = ["-c", "test"]
    options.parse!(argv)
    expect(options.map).to be_falsey
    expect(options.compact).to be_truthy
    expect(options.strip).to be_falsey
  end

  it "sets strip" do
    argv = ["-s", "test"]
    options.parse!(argv)
    expect(options.map).to be_falsey
    expect(options.compact).to be_falsey
    expect(options.strip).to be_truthy
  end

  it "sets rails" do
    argv = ["-r", "test"]
    options.parse!(argv)
    expect(options.map).to be_falsey
    expect(options.compact).to be_falsey
    expect(options.rails).to be_truthy
  end
end

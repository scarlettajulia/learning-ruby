require './class/wli'

describe WLI do
  it "no one likes this" do 
    wli = WLI.new([])
    expect(wli.likes).to eq("No one likes this")
  end

  it "one people likes this" do 
    wli = WLI.new(["Peter"])
    expect(wli.likes).to eq("Peter likes this")
  end

  it "two people likes this" do 
    wli = WLI.new(["Jacob", "Alex"])
    expect(wli.likes).to eq("Jacob and Alex like this")
  end

  it "three people likes this" do 
    wli = WLI.new(["Max", "John", "Mark"])
    expect(wli.likes).to eq("Max, John and Mark like this")
  end

  it "four people likes this" do 
    wli = WLI.new(["Alex", "Jacob", "Mark", "Max"])
    expect(wli.likes).to eq("Alex, Jacob and 2 like this")
  end
end
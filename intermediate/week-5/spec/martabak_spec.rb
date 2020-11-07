require './class/martabak'

describe Martabak do
  it "is delicious" do 
    martabak = Martabak.new("chocolate")
    expect(martabak.taste).to eq("martabak chocolate is delicious")
  end
end
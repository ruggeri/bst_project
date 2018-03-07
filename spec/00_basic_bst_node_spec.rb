require 'rspec'
require 'bst_node'

describe BSTNode do
  it "takes in a value in the constructor and defines it as an attr_reader" do
    bst_node = BSTNode.new(value: 5)
    expect(bst_node.value).to eq(5)
  end

  it "sets #left and #right as attr_accesors" do
    left = BSTNode.new(value: 2)
    right = BSTNode.new(value: 7)

    bst_node = BSTNode.new(value: 4, left: left, right: right)

    expect(bst_node.left.value).to eq(2)
    expect(bst_node.right.value).to eq(7)
  end

end

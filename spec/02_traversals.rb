require 'rspec'
require 'bst_node'

describe BSTNode do
  let(:prefilled_root) do
    root = nil
    [5, 3, 7, 1, 4, 9, 0, 2, 1.5, 10].each do |el|
      root = BSTNode.insert(root, el)
    end

    root
  end
  #############################
  # prefilled_root looks like #
  #             (5)           #
  #            /   \          #
  #          (3)   (7)        #
  #         /  \      \       #
  #      (1)   (4)    (9)     #
  #     /   \            \    #
  #   (0)   (2)          (10) #
  #        /                  #
  #      (1.5)                #
  #############################

  describe '#depth' do
    it 'finds the depth of the tree' do
      root = BSTNode.new(value: 5)
      expect(BSTNode.depth(root)).to eq(1)
      expect(BSTNode.depth(prefilled_root)).to eq(5)
    end
  end

  describe '#is_balanced?' do
    let(:balanced_root) do
      root = nil
      [14, 4, 16, 1, 10, 20].each do |el|
        BSTNode.insert(root, el)
      end

      root
    end

    context 'when tree is balanced' do
      it 'returns true' do
        expect(BSTNode.is_balanced?(balanced_root)).to eq(true)
      end
    end

    context 'when tree is unbalanced' do
      it 'returns false' do
        expect(BSTNode.is_balanced?(prefilled_root)).to eq(false)
      end
    end
  end

  describe '#range' do
    it 'visits left children, then itself, then right children' do
      in_order_array = [0, 1, 1.5, 2, 3, 4, 5, 7, 9, 10]
      expect(BSTNode.range(prefilled_root)).to eq(in_order_array)
    end

    it 'filters some children out' do
      in_order_array = [3, 4, 5, 7]
      expect(BSTNode.range(prefilled_root, min: 2.5, max: 8)).to eq(in_order_array)
    end
  end
end

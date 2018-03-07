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

  describe '#insert' do
    it 'inserts values in the correct order' do
      root = BSTNode.insert(nil, 5)
      expect(root.value).to eq(5)

      root = BSTNode.insert(root, 2)
      expect(root.left.value).to eq(2)

      root = BSTNode.insert(root, 8)
      expect(root.right.value).to eq(8)

      root = BSTNode.insert(root, 1)
      intermediate_root = root.left
      # intermediate_root is the node with value of 2

      expect(intermediate_root.left.value).to eq(1)
    end

    it 'prefilled inserts values in the correct order' do
      expect(prefilled_root.value).to eq(5)
      expect(prefilled_root.left.value).to eq(3)
      expect(prefilled_root.left.left.value).to eq(1)
      expect(prefilled_root.left.left.left.value).to eq(0)
      expect(prefilled_root.left.left.right.value).to eq(2)
      expect(prefilled_root.left.left.right.left.value).to eq(1.5)
      expect(prefilled_root.left.right.value).to eq(4)
      expect(prefilled_root.left.right.right).to eq(nil)
      expect(prefilled_root.right.value).to eq(7)
      expect(prefilled_root.right.left).to eq(nil)
      expect(prefilled_root.right.right.value).to eq(9)
      expect(prefilled_root.right.right.right.value).to eq(10)
    end
  end

  describe '#find' do
    it 'returns nil if the value is not in the BST' do
      expect(BSTNode.find(prefilled_root, -5)).to eq(nil)
    end

    it 'returns the correct node if value is in the BST' do
      found_node = BSTNode.find(prefilled_root, 4)
      expect(found_node).to be_instance_of(BSTNode)
      expect(found_node.value).to eq(4)
    end
  end

  describe '#maximum' do
    it 'finds the maximum' do
      expect(BSTNode.maximum(prefilled_root)).to eq(10)
    end

    it 'finds the maximum of subtrees' do
      subtree_root = prefilled_root.left

      expect(BSTNode.maximum(subtree_root)).to eq(4)
    end
  end

  describe '#delete' do
    context 'if target node has no children' do
      it 'deletes the target node' do
        # 4 is supposed to be right child of the left child of root.
        new_root = BSTNode.delete(prefilled_root, 4)

        expect(new_root.left.right).to eq(nil)
      end

      it 'sets the root to nil if the target node is the root' do
        root = nil
        root = BSTNode.insert(root, 5)
        root = BSTNode.delete(root, 5)

        expect(root).to eq(nil)
      end
    end

    context 'if target node has one child' do
      it 'deletes the target node and promotes its child' do
        root = BSTNode.delete(prefilled_root, 7)
        expect(root.right.value).to eq(9)
      end
    end

    context 'if target node has two children' do
      it 'replaces target node with maximum of target\'s left tree' do
        root = BSTNode.delete(prefilled_root, 3)
        expect(root.left.value).to eq(2)
      end

      context 'when promoted child has its own child' do
        it 'promotes its child to take its place' do
          root = BSTNode.delete(prefilled_root, 3)
          # the above action promotes 2 to replace 3
          expect(root.left.left.right.value).to eq(1.5)
        end
      end
    end
  end
end

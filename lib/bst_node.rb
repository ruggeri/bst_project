class BSTNode
  attr_reader :value, :left, :right

  # Phase 00.
  def initialize(value:, left: nil, right: nil)
    @value = value
    @left = left
    @right = right
  end

  # Phase 01.
  def self.insert(root, value)
    if root.nil?
      return BSTNode.new(value: value)
    end

    if value < root.value
      new_left = insert(root.left, value)
      new_root = BSTNode.new(value: root.value, left: new_left, right: root.right)
      return new_root
    else
      new_right = insert(root.right, value)
      new_root = BSTNode.new(value: root.value, left: root.left, right: new_right)
      return new_root
    end
  end

  def self.find(root, value)
    return nil if root.nil?

    if root.value == value
      return root
    elsif value < root.value
      return self.find(root.left, value)
    else
      return self.find(root.right, value)
    end
  end

  # helper methods for #delete:
  def self.maximum(root)
    return nil if root.nil?
    return self.maximum(root.right) if root.right
    return root.value
  end

  def self.delete(root, value)
    return nil if root.nil?

    if value < root.value
      new_left = self.delete(root.left, value)
      return BSTNode.new(value: root.value, left: new_left, right: root.left)
    elsif value > root.value
      new_right = self.delete(root.right, value)
      return BSTNode.new(value: root.value, left: root.left, right: new_right)
    end

    if root.left.nil?
      return root.right
    elsif root.right.nil?
      return root.left
    end

    left_max = self.maximum(root.left)
    new_left = self.delete(root.left, left_max)
    return BSTNode.new(
      value: left_max,
      left: new_left,
      right: root.right
    )
  end

  # Phase 02.
  def self.depth(root)
    return 0 if root.nil?
    left_depth = self.depth(root.left)
    right_depth = self.depth(root.right)

    return [left_depth, right_depth].max + 1
  end

  def self.is_balanced?(root)
    return true if root.nil?

    return false unless self.is_balanced?(root.left)
    return false unless self.is_balanced?(root.right)

    left_depth = self.depth(root.left)
    right_depth = self.depth(root.right)

    return (left_depth - right_depth).abs <= 1
  end

  def self.range(root, arr: [], min: nil, max: nil)
    return arr if root.nil?

    if min.nil? || min < root.value
      self.range(root.left, arr: arr, min: min, max: max)
    end

    if (min.nil? || min <= root.value) && (max.nil? || root.value <= max)
      arr << root.value
    end

    if max.nil? || root.value <= max
      self.range(root.right, arr: arr, min: min, max: max)
    end

    return arr
  end
end

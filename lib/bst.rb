class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if !@root
      @root = BSTNode.new(value)
      return
    end
    BinarySearchTree.insert!(@root,value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node
    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end
    node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value
    if value > node.value
      return BinarySearchTree.find!(node.right, value)
    end
    BinarySearchTree.find!(node.left, value)
  end

  def self.preorder!(node)
    return [] unless node
    arr = [node.value]
    arr += BinarySearchTree.preorder!(node.left) if node.left
    arr += BinarySearchTree.preorder!(node.right) if node.right
    arr
  end

  def self.inorder!(node)
    return [] unless node
    arr = []
    arr += BinarySearchTree.inorder!(node.left) if node.left
    arr << node.value
    arr += BinarySearchTree.inorder!(node.right) if node.right
    arr
  end

  def self.postorder!(node)
    return [] unless node
    arr = []
    arr += BinarySearchTree.postorder!(node.left) if node.left
    arr += BinarySearchTree.postorder!(node.right) if node.right
    arr << node.value
    arr
  end

  def self.height!(node)
    return -1 unless node
    1 + [BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max
  end

  def self.max(node)
    return nil unless node
    return node unless node.right
    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left
    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left
    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node
    case value <=> node.value
    when -1
      node.left = BinarySearchTree.delete!(node.left, value)
    when 1
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      n = node
      node = n.right.min
      node.right = BinarySearchTree.delete_min!(n.right)
      node.left = n.left
    end
    node
  end
end

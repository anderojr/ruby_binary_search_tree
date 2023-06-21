# frozen_string_literal: true

require_relative 'node'

# A class that defines a tree using the Node class
class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array, start_index = 0, end_index = array.size - 1)
    return nil if start_index > end_index

    middle = (start_index + end_index) / 2
    root_node = Node.new(array[middle])

    root_node.left = build_tree(array, start_index, middle - 1)
    root_node.right = build_tree(array, middle + 1, end_index)

    root_node
  end

  def insert(value, node = root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      successor = node.right
      successor = successor.left while successor.left

      node.data = successor.data
      node.right = delete(successor.data, node.right)
    end
    node
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end
end

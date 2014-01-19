# coding: utf-8
require File.expand_path('../lib/array_ext', __FILE__)

class InvalidArrayException < StandardError; end

# 对于所给矩阵，按顺时针方向逐层索引每个元素
# e.g.
# [[ 0, 1, 2, 3, 4],
#  [15,16,17,18, 5],
#  [14,23,24,19, 6],
#  [13,22,21,20, 7],
#  [12,11,10, 9, 8]]

# 第一层                          cycle_step   # => 0
#  [ 0, 1, 2, 3, 4],
#  [15,          5],             cycle_left   # => 0
#  [14,          6],             cycle_top    # => 0
#  [13,          7],             cycle_width  # => 5
#  [12,11,10, 9, 8]              cycle_height # => 5

# 第二层                          cycle_step   # => 1
#  [              ],
#  [   16,17,18   ],             cycle_left   # => 1
#  [   23,   19   ],             cycle_top    # => 1
#  [   22,21,20   ],             cycle_width  # => 3
#  [              ]              cycle_height # => 3

# 第三层                          cycle_step   # => 2
#  [              ],
#  [              ],             cycle_left   # => 2
#  [      24,     ],             cycle_top    # => 2
#  [              ],             cycle_width  # => 1
#  [              ]              cycle_height # => 1

# 支持反方向（逆时针）逐层索引
# 支持 #[], each, length, reverse, 以及Enumerable的各个方法
class ArrayClockwise
  include Enumerable
  attr_accessor :data

  def initialize(array)
    raise InvalidArrayException, "Invalid array" unless array.is_a? Array
    raise InvalidArrayException, "Invalid array" unless array.length > 0
    raise InvalidArrayException, "Invalid array" unless array[0].is_a? Array
    raise InvalidArrayException, "Invalid array" unless array[0].length > 0

    @data = array
    @width, @height = array.length, array[0].length

    @cycle_count   = ( (@width > @height ? @height : @width) / 2.0 ).ceil
    @cycle = []
    @cycle_count.times do |i|
      this_cycle = {:w => @width - i * 2, :h => @height - i * 2}
      this_count = (this_cycle[:w] == 1 or this_cycle[:h] == 1) ?
          (this_cycle[:w] * this_cycle[:h] ) :
          ((this_cycle[:w] + this_cycle[:h]) * 2 - 4)
      @cycle << (@cycle[-1] || 0) + this_count
    end
  end

  def [](index)
    cycle_index = -1
    @cycle.each_with_index do |cycle_count, i|
      if cycle_count > index
        cycle_index = i
        break
      end
    end

    this_cycle_left   = cycle_index
    this_cycle_top    = cycle_index
    this_cycle_width  = @width  - 2 * cycle_index
    this_cycle_height = @height - 2 * cycle_index

    this_cycle_step_length = ((@cycle[cycle_index] - @cycle.before(cycle_index,0)) / 4.0).ceil

    this_cycle_index  = (cycle_index >= 1 ) ? index - @cycle[cycle_index-1] : index
    this_cycle_step   = this_cycle_index / this_cycle_step_length
    this_cycle_offset = this_cycle_index % this_cycle_step_length
    this_cycle_right  = this_cycle_top + this_cycle_width - 1
    this_cycle_bottom = this_cycle_left + this_cycle_height - 1
    x, y = * case this_cycle_step
               when 0
                 [this_cycle_left, this_cycle_top + this_cycle_offset]
               when 1
                 [this_cycle_left + this_cycle_offset, this_cycle_right]
               when 2
                 [this_cycle_bottom, this_cycle_right - this_cycle_offset]
               when 3
                 [this_cycle_bottom - this_cycle_offset, this_cycle_top]
             end
    @data[x][y]
  end

  def each
    self.length.times do |i|
      yield(self[i])
    end
  end

  def length
    @data.flatten.length
  end

  def reverse
    @data = @data.transpose
    self
  end
end
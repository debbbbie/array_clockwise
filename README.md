array_clockwise
===============
[![Build Status](https://travis-ci.org/debbbbie/array_clockwise.png?branch=master)](https://travis-ci.org/debbbbie/array_clockwise)

对于所给矩阵，按顺时针方向逐层索引每个元素

    a = ArrayClockwise.new [
                               [ 0, 1, 2, 3, 4],
                               [15,16,17,18, 5],
                               [14,23,24,19, 6],
                               [13,22,21,20, 7],
                               [12,11,10, 9, 8]
                           ]
    a.map{|data| data }  # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]

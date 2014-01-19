require './array_clockwise'
a = ArrayClockwise.new [
                           [12, 32,  9, 11, 34],
                           [ 8, 54, 76, 23,  7],
                           [27, 18, 25,  9, 43],
                           [11, 23, 78, 63, 19],
                           [ 9, 22, 56, 31, 05]
                       ]
ret = a.inject(0){|sum, n| sum + n }
print ret # => 705
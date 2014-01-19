require 'spec_helper'

describe ArrayClockwise do
  it "invalid array check" do
    expect{ ArrayClockwise.new(nil)    }.to raise_error(InvalidArrayException)
    expect{ ArrayClockwise.new(3)      }.to raise_error(InvalidArrayException)
    expect{ ArrayClockwise.new([])     }.to raise_error(InvalidArrayException)
    expect{ ArrayClockwise.new([ 3 ])  }.to raise_error(InvalidArrayException)
    expect{ ArrayClockwise.new([ [] ]) }.to raise_error(InvalidArrayException)
  end

  it "#each" do
    r = ArrayClockwise.new [
                               [ 0, 1, 2, 3, 4],
                               [15,16,17,18, 5],
                               [14,23,24,19, 6],
                               [13,22,21,20, 7],
                               [12,11,10, 9, 8]
                           ]
    i = 0
    r.each do |data|
      data.should be(i)
      i += 1
    end
  end
  it "#map" do
    r = ArrayClockwise.new [
                               [ 0, 1, 2, 3, 4],
                               [15,16,17,18, 5],
                               [14,23,24,19, 6],
                               [13,22,21,20, 7],
                               [12,11,10, 9, 8]
                           ]
    i = 0
    (r.map{|data| data } == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).should be(true)
  end
  it "#each_with_index" do
    r = ArrayClockwise.new [
                               [ 0, 1, 2, 3, 4],
                               [15,16,17,18, 5],
                               [14,23,24,19, 6],
                               [13,22,21,20, 7],
                               [12,11,10, 9, 8]
                           ]
    r.each_with_index do |data, i|
      data.should be(i)
    end
  end

  it "#reverse" do
    r = ArrayClockwise.new [
                               [ 0,15,14,13,12],
                               [ 1,16,23,22,11],
                               [ 2,17,24,21,10],
                               [ 3,18,19,20, 9],
                               [ 4, 5, 6, 7, 8]
                           ]
    r.reverse
    r.each_with_index do |data, i|
      data.should be(i)
    end
  end

  it "1x1 array should work" do
    r = ArrayClockwise.new [
                               [0]
                           ]
    r.length.times {|i| r[i].should be(i) }
  end
  it "2x2 array should work" do
    r = ArrayClockwise.new [
                               [0, 1],
                               [3, 2]
                           ]
    r.length.times {|i| r[i].should be(i) }
  end
  it "3x3 array should work" do
    r = ArrayClockwise.new [
                               [0, 1, 2],
                               [7, 8, 3],
                               [6, 5, 4]
                           ]
    r.length.times {|i| r[i].should be(i) }
  end
  it "4x4 array should work" do
    r = ArrayClockwise.new [
                               [ 0, 1, 2, 3],
                               [11,12,13, 4],
                               [10,15,14, 5],
                               [ 9, 8, 7, 6]
                           ]
    r.length.times {|i| r[i].should be(i) }
  end
  it "5x5 array should work" do
    r = ArrayClockwise.new [
                               [ 0, 1, 2, 3, 4],
                               [15,16,17,18, 5],
                               [14,23,24,19, 6],
                               [13,22,21,20, 7],
                               [12,11,10, 9, 8]
                           ]
    r.length.times {|i| r[i].should be(i) }
  end

  it "#first" do
    r = ArrayClockwise.new [
                               [ 0, 1, 2, 3, 4],
                               [15,16,17,18, 5],
                               [14,23,24,19, 6],
                               [13,22,21,20, 7],
                               [12,11,10, 9, 8]
                           ]
    r.first.should be(r.data[0][0])
  end

end
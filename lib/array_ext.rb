class Array

  unless Array.respond_to? :before
    def before(index, default = nil)
      index - 1 >= 0 ? self[index - 1] : default
    end
  end
end

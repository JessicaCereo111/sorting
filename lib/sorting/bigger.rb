# encoding: utf-8



module Sorting

  # A value whose #<=> method will always compare as being the bigger value.
  # Useful for defaultizing potentially nil values before comparing/sorting.
  #
  # @example
  #     age = person.age || Sorting::Bigger
  #
  # @see Sorting::Smaller
  #
  # @note
  #   require 'sorting' loads this module
  #
  module Bigger
    extend Comparable

    # @return [1]
    #   Comparison. Pretends this object is bigger and hence always returns 1
    #
    def self.<=>(other)
      1
    end

    # @private
    # @see Numeric#coerce
    #
    def self.coerce(other)
      [Smaller, self]
    end

    # @private
    # @note
    #   Rails' ActiveSupport patches DateTime incorrectly (doesn't use coerce).
    #   This is a workaround
    #
    def self.to_datetime
      self
    end

    # @private
    # Enables comparisons with arrays
    #
    def self.to_ary
      [self]
    end

    # @private
    # @todo
    #   (SR) Figure out why this ended up here. I (SR) think it was due to
    #   some comparison failing without it, but I don't remember which.
    #   The specific case should be documented.
    #   It is not due to "somestring" <=> Sorting::Bigger, that inverts
    #   the expression to Sorting::Bigger <=> "somestring"
    #
    def self.to_str
      self
    end

    # @private
    # @see Object#inspect
    #
    def self.inspect
      "#<Sorting::Bigger>"
    end
  end
end

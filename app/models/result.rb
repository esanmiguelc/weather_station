class Result
  attr_reader :value
  def initialize(value, errors = nil)
    @value = value
  end

  def errors?
    !errors.nil?
  end

  def self.success(value)
    new(value)
  end
end


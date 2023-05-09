class Result
  attr_reader :value, :errors
  def initialize(value, errors = nil)
    @value = value
    @errors = errors
  end

  def errors?
    !errors.nil?
  end

  def self.success(value)
    new(value)
  end

  def self.fail(error)
    new(nil, error)
  end
end


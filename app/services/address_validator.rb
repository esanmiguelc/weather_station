class AddressValidator
  def self.validate(address)
    zip = address.scan(/\b\d{5}\b/).first

    return Result.fail(:invalid_address) unless zip

    Result.success(Address.new(zip))
  end
end

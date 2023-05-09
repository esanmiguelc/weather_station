class AddressValidator
  def self.validate(address)
    # We check if the address has a 5-digit string and consider that the zip
    zip = address.scan(/\b\d{5}\b/).first

    return Result.fail(:invalid_address) unless zip

    Result.success(Address.new(zip))
  end
end

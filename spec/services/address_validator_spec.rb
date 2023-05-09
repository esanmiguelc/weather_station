require 'rails_helper'

describe AddressValidator do
  it "returns the zip when it is valid" do
    valid_address = Address.new("60647")

    result = AddressValidator.validate("60647")

    expect(result.errors?).to eq(false)
    expect(result.value).to eq(valid_address)
  end

  it "returns an error when it is not valid" do
    result = AddressValidator.validate("not a zip")

    expect(result.errors?).to eq(true)
    expect(result.errors).to eq("Invalid address")
  end
end

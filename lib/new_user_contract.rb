class NewUserContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:email).filled(:string)
    required(:phone).filled(:string)
    required(:mobile).filled(:string)
    optional(:address).filled(:string)
    optional(:photo).filled(:string)
  end


  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
  end


  rule(:phone) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value)
      key.failure('has invalid format')
    end
  end

 rule(:mobile) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value)
      key.failure('has invalid format')
    end
  end
end



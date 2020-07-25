class EditUserContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:email).filled(:string)
    required(:phone).filled(:string)
    required(:mobile).filled(:string)
    optional(:password).maybe(:string, min_size?: 6)
    optional(:password_confirmation)
    optional(:address).maybe(:string)
    optional(:photo)
  end

  rule(:name) do
    unless /^(?=.{5,15}$)(?![_. ])(?!.*[_.]{2})[a-zA-Z0-9 ]+(?<![_. ])$/i.match?(value)
      key.failure('Has invalid format')
    end

  end


  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('Has invalid format')
    end
  end


  rule(:phone) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value)
      key.failure('Has invalid format')
    end
  end
  
    rule(:mobile) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value)
      key.failure('Has invalid format')
    end
  end

end


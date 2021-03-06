class NewUserContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:email).filled(:string)
    required(:phone).filled(:string)
    required(:mobile).filled(:string)
    required(:password).filled(:string, min_size?: 6)
    required(:password_confirmation).filled(:string)
    optional(:address).maybe(:string)
    optional(:photo)
  end

  rule(:name) do
    unless /^(?=.{3,15}$)(?![_. ])(?!.*[_.]{2})[a-zA-Z0-9 ]+(?<![_. ])$/i.match?(value.strip)
      key.failure('has invalid format')
    end

  end


  rule(:email) do
    unless /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/i.match?(value.strip)
      key.failure('has invalid format')
    end
    if User.find_by_email(value)
      key.failure('has been taken')
    end

  end

  rule(:phone) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value.strip)
      key.failure('has invalid format')
    end
  end
  
    rule(:mobile) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value.strip)
      key.failure('has invalid format')
    end
  end


  rule(:password, :password_confirmation) do
    if values[:password] != values[:password_confirmation]
      key.failure('confirmation does not match password')
    end
  end



end



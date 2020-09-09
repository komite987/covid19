class EditUserContract < Dry::Validation::Contract
  params do
    optional(:name).maybe(:string)
    optional(:email).maybe(:string)
    optional(:phone).maybe(:string)
    optional(:mobile).maybe(:string)
    optional(:password).maybe(:string, min_size?: 6)
    optional(:password_confirmation)
    optional(:address).maybe(:string)
    optional(:photo)
  end


  rule(:name) do
    if value.present?
      unless /^(?=.{3,15}$)(?![_. ])(?!.*[_.]{2})[a-zA-Z0-9 ]+(?<![_. ])$/i.match?(value.strip)
        key.failure('has invalid format')
      end
    end
  end

  rule(:email) do
    if value.present?

      unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value.strip)
        key.failure('has invalid format')
      end
    end
  end

  rule(:phone) do
    if value.present?

      unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value.strip)
        key.failure('has invalid format')
      end
    end
  end

  rule(:mobile) do
    if value.present?

      unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value.strip)
        key.failure('has invalid format')
      end
    end
  end

end


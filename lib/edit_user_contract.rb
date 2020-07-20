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


  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end

      if User.find_by_email(value)
        key.failure('Email has been taken')
    end
  end


  rule(:phone, :mobile) do
    unless /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i.match?(value)
      key.failure('has invalid format')
    end
  end

  rule(:password, :password_confirmation) do
    # if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    #   params[:user].delete(:password)
    #   params[:user].delete(:password_confirmation)
    # end

    if values[:password] != values[:password_confirmation]
      key.failure('Password confirmation does not match password .')
    end
  end



end


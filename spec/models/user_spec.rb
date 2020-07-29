require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'validation test' do
    it 'ensures email presence' do
      user = User.new(name: 'username', password: '123456',password_confirmation: '123456', phone: '04188008800', mobile: '0988323323').save
      expect(user).to eq(false)
    end

    it 'ensures name presence' do
      user = User.new(email: 'username@gmail.com', password: '123456',password_confirmation: '123456', phone: '04188008800', mobile: '0988323323').save
      expect(user).to eq(false)
    end

    it 'ensures phone presence' do
      user = User.new(name: 'username', email: 'username@gmail.com', password: '123456',password_confirmation: '123456', mobile: '0988323323').save
      expect(user).to eq(false)
    end

    it 'ensures mobile presence' do
      user = User.new(name: 'username', email: 'username@gmail.com', password: '123456',password_confirmation: '123456', phone: '0988323323').save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(name: 'username', email: 'username@gmail.com',password_confirmation: '123456', mobile: '0988323323', phone: '0988323323').save
      expect(user).to eq(false)
    end

    it 'ensures password at least 6 digits' do
      user = User.new(name: 'username', email: 'username@gmail.com',password: '12345',password_confirmation: '12345', mobile: '0988323323', phone: '0988323323').save
      expect(user).to eq(false)
    end

    it 'ensures password confirmation match password' do
      user = User.new(name: 'username', email: 'username@gmail.com',password: '123456',password_confirmation: '123457', mobile: '0988323323', phone: '0988323323').save
      expect(user).to eq(false)
    end


  end

end

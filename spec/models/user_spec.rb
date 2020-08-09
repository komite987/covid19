require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'validation test' do
    it 'ensures email presence' do
      subject.email = ''
      expect(subject).not_to be_valid
    end
    it 'ensures email uniqueness' do
      user = create :user
      another_user = build :user, email:  user.email  
      expect(another_user).not_to be_valid
    end


    it 'ensures name presence' do
      subject.name = ''
      expect(subject).not_to be_valid
    end

    it 'ensures phone presence' do
      subject.phone = ''
      expect(subject).not_to be_valid
    end

    it 'ensures mobile presence' do
      subject.mobile = ''
      expect(subject).not_to be_valid
    end

    it 'ensures password presence' do
      subject.password = ''
      expect(subject).not_to be_valid
    end

    it 'ensures password at least 6 digits' do
      subject.password = '12345'
      expect(subject).not_to be_valid
    end

    it 'ensures password confirmation match password' do
      subject.password = '123456'
      subject.password_confirmation = '123455'
      expect(subject).not_to be_valid
    end


  end

end

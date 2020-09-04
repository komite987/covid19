class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  mount_uploader :photo, ProfileUploader
  before_validation :strip_whitespace, :only => [:name, :email, :mobile, :phone, :address]

  validates_presence_of :name, :phone, :mobile

  def strip_whitespace
    self.name = self.name.strip.split.join(" ") unless self.name.nil?
    self.email = self.email.strip unless self.email.nil?
    self.phone = self.phone.strip unless self.phone.nil?
    self.mobile = self.mobile.strip unless self.mobile.nil?
    self.address = self.address.strip.split.join(" ") unless self.address.nil?
  end


end

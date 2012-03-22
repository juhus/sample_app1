# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	has_many :microposts, dependent: :destroy
	before_save :create_remember_token	#callback method to create the remember token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, 
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	def feed
		# This is preliminary. See "Following users" for the full implementation.
    	Micropost.where("user_id = ?", id)
	end

	private			# Not to expose to outside users
	  	def create_remember_token
	    	self.remember_token = SecureRandom.urlsafe_base64	#returns a random string of length 16 composed of the characters A–Z, a–z, 0–9, “-”, and “_” (for a total of 64 possibilities)
	  	end														#means that the probability of two remember tokens being the same is 1/64^(16)=2^(-96)≈10^(−29), which is negligible.
end

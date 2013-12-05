class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	# (Since destroying a user should also destroy that user’s relationships, 
	# we’ve gone ahead and added dependent: :destroy to the association; 
	# writing a test for this is left as an exercise 
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	# would assemble an array using the followed_id in the relationships table. 
	# But, as noted in Section 11.1.1, user.followeds is rather awkward; 
	# far more natural is to use “followed users” as a plural of “followed”, 
	# and write instead user.followed_users for the array of followed users. 
	# Naturally, Rails allows us to override the default, in this case using the :source parameter (Listing 11.10), 
	# which explicitly tells Rails that the source of the followed_users array is the set of followed ids.
	has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	before_save { email.downcase! }
	before_create :create_remember_token

	has_secure_password
	validates :name, presence: true, length: { maximum: 50 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# A valid email regex that disallows double dots in email addressed. 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence:   true,
	format:     { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }

	def feed
	    # This is preliminary. See "Following users" for the full implementation.
	    # Micropost.where("user_id = ?", id)
        Micropost.from_users_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy!
	end


	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
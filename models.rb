class User < ActiveRecord::Base
	has_one :profile
	has_many :posts
end

class Post < ActiveRecord::Base
	belongs_to :user
end

class Profile < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end
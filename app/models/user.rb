require 'digest/md5'

class User < ActiveRecord::Base

has_many :tweets

has_many :follower_relationships, classname: 'Relationship', foreign_key: 'followed_id'
has_many :followed_relationships, classname: 'Relationship', foreign_key: 'follower_id'
has_many :followers, through: :follower_relationships
has_many :followeds, through: :followed_relationships

before_validation :prep_email
before_save :create_avatar_url

has_secure_password

validates :email, uniqueness: true, presence: true, format: { with: /\A[\w\.+-]+@([\w]+\.)+\w+\z/ }
validates :username, uniqueness: true, presence: true
validates :name, presence: true

def following? user
  self.followeds.include? user
end

private

def prep_email
  self.email = self.email.strip.downcase if self.email
end

def create_avatar_url
  self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
end

end

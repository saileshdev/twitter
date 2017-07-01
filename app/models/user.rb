require 'digest/md5'

class User < ActiveRecord::Base

has_secure_password

validates :email, uniqueness: true, presence: true, format: { with: /^[\w\.+-]+@([\w]+\.)+\w+$/ }
validates :username, uniqueness: true, presence: true
validates :name, presence: true

private

def prep_email
  self.email = self.email.strip.downcase if self.email
end

def create_avatar_url
  self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
end

end

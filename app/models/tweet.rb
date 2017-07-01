class Tweet < ActiveRecord::Base
	default_scope { order(created_at: :desc) }

	belongs_to :user

	validates :content, length: { maximum: 140 }
end

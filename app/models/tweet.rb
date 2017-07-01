class Tweet < ActiveRecord::Base
	default_scope order: "created_at DESC"

	validates :content, length: { maximum: 140 }
end

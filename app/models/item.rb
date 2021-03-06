class Item < ActiveRecord::Base
  acts_as_taggable
	belongs_to :user
	belongs_to :category
	validates :category, presence: true
	validates :title, presence: true, length: { maximum: 30 } 
	validates :price, presence: true
	validates :description, presence: true, length: { maximum: 2000 }
	validates :user_id, presence: true
	has_attached_file :image, styles: { large: "600x600", medium: "250x250", thumb:"100x100#"}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

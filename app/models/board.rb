class Board < ActiveRecord::Base
	attr_accessible :height, :name, :timezone, :width

	has_many :tiles, through: :advertisements
	has_many :advertisements
	belongs_to :user
	has_one :payment_detail, as: :payable

	validates :name, presence: true
	validates :width, presence: true
	validates_numericality_of :width, :greater_than => 0
	validates :height, presence: true
	validates_numericality_of :height, :greater_than => 0
	validates :timezone, presence: true
	validates_inclusion_of :timezone, :in => ActiveSupport::TimeZone.zones_map

	before_create :fakeAd

	def age
		tiles.each do |t|
			t.age
		end
		advertisements.each do |a|
			a.charge
		end
	end 

	private
	def fakeAd
			ad = advertisements.build(x_location: 0, y_location: 0, width: self.width, height: self.height)
			ad.image = "rails.png"
			ad.user = user
	end
end

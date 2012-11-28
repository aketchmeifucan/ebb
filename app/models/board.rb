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
end

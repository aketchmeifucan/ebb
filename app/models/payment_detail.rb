class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount 

  belongs_to :payable, polymorphic: true
  belongs_to :user

  validates_numericality_of :amount, presence: true
end

class PayBack
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Float
  field :withdrawn, :type =>Boolean, :default => :false
  scope :online, where(:withdrawn => false)

  belongs_to :paid_to, class_name: 'User', inverse_of: :paybacks
  belongs_to :from_installment, class_name: "Installment", inverse_of: :paybacks
  belongs_to :from_loan, class_name: "Loan", inverse_of: :paybacks
end

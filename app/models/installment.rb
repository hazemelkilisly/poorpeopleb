class Installment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Float
  field :payment_date, :type =>DateTime
  field :days_diff, :type =>Integer
  field :number, :type =>Integer


  belongs_to :case
  has_many :paybacks, class_name: "PayBack", inverse_of: :from_installment
  belongs_to :creator, class_name: "Admin", inverse_of: :created_installments

end

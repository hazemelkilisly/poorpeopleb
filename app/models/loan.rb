class Loan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, :type => Integer
    validates_presence_of :quantity, :message => "should be entered!"
  field :donation, :type => Boolean
    validates_presence_of :donation, :message => "should be entered!"

  field :city, :type => String
    validates_presence_of :city, :message => "should be entered!"
  field :destrict, :type => String
    validates_presence_of :destrict, :message => "should be entered!"
  field :address, :type => String
    validates_presence_of :address, :message => "should be entered!"

  field :comments, :type => String

  belongs_to :user

  belongs_to :case

  has_many :paybacks, class_name: "PayBack", inverse_of: :from_loan

  scope :pending, where(:collected => false)
  scope :active, where(:collected => true)
  scope :active_payable, where(:collected => true, :donation=> false)

  field :collected, :type => Boolean, :default => false

  def percentage
    ((quantity * 1.0 / self.case.loans.active_payable.sum(:quantity)) * 100.0).round(2)
  end
end

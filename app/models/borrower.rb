class Borrower
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
    validates_presence_of :name, :message => "should be entered!"

  field :phone, :type => String
    validates_presence_of :phone, :message => "should be entered!"
    
  field :city, :type => String
    validates_presence_of :city, :message => "should be entered!"
  field :destrict, :type => String
    validates_presence_of :destrict, :message => "should be entered!"
  field :address, :type => String
    # validates_presence_of :address1, :message => "should be entered!"


  field :age, :type => Integer
    # validates_presence_of :age, :message => "should be entered!"
  field :job, :type => String
    validates_presence_of :job, :message => "should be entered!"
  field :marital_status, :type => String
    # validates_presence_of :marital_status, :message => "should be entered!"
  field :childen_num, :type => Integer, :default => 0
    validates_presence_of :childen_num, :message => "should be entered!"
  field :dependencies_num, :type => Integer, :default => 0
    validates_presence_of :dependencies_num, :message => "should be entered!"
  field :dependencies_description, :type => String
    # validates_presence_of :dependencies_description, :message => "should be entered!"
  field :monthly_income, :type => Integer
    validates_presence_of :monthly_income, :message => "should be entered!"
  field :health_status, :type => String
    # validates_presence_of :health_status, :message => "should be entered!"
  field :suspended, :type =>Boolean, :default => :false

  field :expertise, :type =>String
    # validates_presence_of :expertise, :message => "should be entered!"

  belongs_to :creator, class_name: 'Admin', inverse_of: :created_borrowers
  has_and_belongs_to_many :owned_cases, class_name: 'Case', inverse_of: :owner  
end

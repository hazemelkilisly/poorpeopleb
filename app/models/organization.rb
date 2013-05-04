class Organization
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
    validates_presence_of :title, :message => "should be entered!"
  field :description, :type => String
    validates_presence_of :description, :message => "should be entered!"
  field :phone, :type => String
    validates_presence_of :phone, :message => "should be entered!"
  field :website, :type => String

  field :city, :type => String
    validates_presence_of :city, :message => "should be entered!"
  field :destrict, :type => String
  field :address, :type => String

  field :suspended, :type => Boolean, :default => :false

  scope :active, where(:suspended => false)
  scope :suspends, where(:suspended => true)

  has_many :admins, class_name: 'Admin'

end

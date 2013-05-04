class Admin
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, :type => String
    validates_presence_of :name, :message => "should be entered!"

  field :phone, :type => String
    # validates_presence_of :phone, :message => "should be entered!"
    
  field :city, :type => String
    # validates_presence_of :city, :message => "should be entered!"
  field :suspended, :type => Boolean, :default => :false

  has_many :created_borrowers, class_name: 'Borrower', inverse_of: :creator
  has_many :created_cases, class_name: 'Case', inverse_of: :creator
  has_many :created_installments, class_name: "Admin", inverse_of: :creator

  has_many :created_admins, class_name: 'Admin', inverse_of: :admin_creator
  belongs_to :admin_creator, class_name: 'Admin', inverse_of: :created_admins

  has_many :updates
  field :locale, :type => String, :default => 'en'

  scope :active, where(:suspended => false)
  scope :suspends, where(:suspended => true)

  belongs_to :organization, class_name: 'Organization'
    validates_presence_of :organization, :message => "should be selected!"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable, :validatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
    validates_presence_of :email, :message => "should be entered!"

  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
end

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
    validates_presence_of :name, :message => "should be entered!"
  field :phone, :type => String
    validates_presence_of :phone, :message => "should be entered!"
  field :location, :type => String
    validates_presence_of :location, :message => "should be entered!"
  # field :city, :type => String
  #   validates_presence_of :city, :message => "should be entered!"
  # field :destrict, :type => String
  #   validates_presence_of :destrict, :message => "should be entered!"
  # field :address, :type => String
  #   validates_presence_of :address, :message => "should be entered!"

  field :suspended, :type => Boolean, :default => :false
  field :show_phone, :type => Boolean, :default => :false
  field :show_location, :type => Boolean, :default => :true

  scope :active, where(:suspended => false)
  scope :suspends, where(:suspended => true)

  field :entity, :type => Boolean
    validates_presence_of :entity, :message => "should be entered!"

  field :default_private_loaning, :type => Boolean, :default => false

  # field :facebook, :type => String
  # field :twitter, :type => String

  field :locale, :type => String, :default => 'en'

  has_many :loans
  
  has_and_belongs_to_many :liked_cases, class_name: "Case", inverse_of: :likers

  has_many :liked_tags, class_name: "TagLike", inverse_of: :liker

  has_many :paybacks, class_name: 'PayBack', inverse_of: :paid_to
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
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

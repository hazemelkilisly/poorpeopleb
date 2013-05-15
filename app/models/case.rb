class Case
  include Mongoid::Document
  include Mongoid::Timestamps
  after_create :link_tags

  field :title, :type => String
  validates_presence_of :title, :message => "should be entered!"

  field :governorate, :type => String
  validates_presence_of :governorate, :message => "should be entered!"

  field :subdivision, :type => String
  # validates_presence_of :subdivision, :message => "should be entered!"

  field :address, :type => String
  # validates_presence_of :address, :message => "should be entered!"

  field :type, :type => String
    validates_presence_of :type, :message => "should be entered!"

  field :description, :type => String
    validates_presence_of :description, :message => "should be entered!"

  field :reason, :type => String
    # validates_presence_of :reason, :message => "should be entered!"

  field :total_money, :type => Integer
    validates_presence_of :total_money, :message => "should be entered!"

  field :starting_date, :type =>DateTime
    validates_presence_of :starting_date, :message => "should be entered!"

  field :experienced_owner, :type =>Boolean
    validates_presence_of :experienced_owner, :message => "should be entered!"

  field :inst_months, :type => Integer
    validates_presence_of :inst_months, :message => "should be entered!"

  field :postponed_insts, :type => Integer, :default => 0

  field :suspended, :type => Boolean, :default => false
  
  field :rating, :type =>Integer

  scope :active, where(:suspended => false)

  scope :suspends, where(:suspended => true)

  has_many :loans do
    def loaned_by(user)
      where(:user.ne => user).exists?
    end
  end

  has_and_belongs_to_many :tags

  belongs_to :creator, class_name: 'Admin', inverse_of: :created_cases

  has_and_belongs_to_many :owners, class_name: 'Borrower', inverse_of: :owned_cases

  has_many :installments
  
  has_and_belongs_to_many :likers, class_name: "User", inverse_of: :liked_cases

  scope :recomendable,->(user){ where(:liker_ids.ne => user.id, :suspended => false) }

  def user_tag_points(user)
    sum = 0
    tags.each do |tag|
      sum += tag.user_likes(user)
    end
    sum
  end

  def remove_tag(tag)
    tg = Tag.where(:word => tag).first
    tags.delete(tg) if tg
  end

  def self.get_user_recomendations(user)
    self.recomendable(user).sort {|a,b| b.user_tag_points(user) <=> a.user_tag_points(user)}.take(10)
    # select { |r| r.user_tag_points(user) > 0 }
  end

  #Returns the ammout paid back by borrower
  def paid_back
    installments.sum(:quantity)
  end

  #Returns the ammout collected from the total requested money
  def remaining_money
    (total_money-paid_back)
  end

  #Returns how many installments are left to be paid
  def remaining_insts
    ((inst_months*2 - installments.count) + postponed_insts)
  end

  #Returns how many installments in total for the case
  def total_insts
    ((inst_months*2) + postponed_insts)
  end

  #Returns the default installment value
  def inst_value
    (remaining_money*1.0/remaining_insts).round(2)
  end

  #Returns the collected money from the total money requested for the case
  def collected_money
    loans.active.sum(:quantity)
  end

  #Returns the collected money PERCENTAGE % from the total money requested for the case
  def collected_perc
    if(collected_money>0)
      (((collected_money*1.0/total_money))*100).round(2)
    else
      0
    end
  end

  #Returns the paid back PERCENTAGE % by borrower
  def paid_back_perc
    if(paid_back>0)
      (((paid_back*1.0/total_money))*100).round(2)
    else
      0
    end
  end

  #Returns the count of the currect installment
  def current_inst
    (installments.count+1)
  end

  #Returns the time that installment "num" should be paid at
  def inst_timing(num)
    passed_days = num*15
    real_due_date = starting_date + passed_days
  end

  #Returns the paid or to be paid value for installment "num"
  def inst_val(num)
    if num <= installments.count
      installments.where(:number => num).first.quantity
    else
      inst_value
    end    
  end

  #Returns if installent "num" payment status ('due','not_due', payment_date)
  def inst_status(num)
      if num <= installments.count
        installments.where(:number => num).first.payment_date.strftime("%B %e, %Y")
      else
        if inst_timing(num) > DateTime.now
          'not_due'
        else
          'due'
        end  
      end
  end

  #Returns the time that current installment is late/early with
  def inst_late_by(y,m,d)
    pay_date = DateTime.new(y,m,d)
    real_due_date = inst_timing(current_inst)
    (pay_date - real_due_date).to_i
  end

  private
    def link_tags
      stop_words = StopWord.in_list
      title_tags = title.filter_tags(stop_words)
      description_tags = description.filter_tags(stop_words)
      all_tags = (title_tags + description_tags).uniq
      Tag.create_from_array(all_tags,self.id)
    end
end

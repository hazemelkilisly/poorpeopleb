class Tag
  include Mongoid::Document

  field :word, :type => String
    validates_uniqueness_of :word
  has_and_belongs_to_many :cases
  has_many :likes, class_name: "TagLike", inverse_of: :tag

  def self.in_list
  	arr = []
  	self.all.each do |w|
      arr << w.word
    end
    if arr.empty?
      nil
    else
      arr
    end
  end

  def self.create_from_array(array,cas)
    cas = Case.find(cas)
    array.each do |item|
      if self.where(:word => item).count > 0
        this_tag = self.where(:word => item).first
        this_tag.cases << cas
        this_tag.save
      else
        this_tag = self.create(:word => item)
        this_tag.cases << cas
        this_tag.save
      end
    end
  end

  def self.to_stop_word(tag)
    tg = self.where(:word => tag).first
    StopWord.create(:word => tg.word)
    tg.likes.delete_all
    tg.delete
  end

  def user_likes(user)
    likes.where(:liker_id => user).sum(:total_likes)
  end

end
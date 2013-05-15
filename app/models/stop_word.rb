class StopWord
  include Mongoid::Document

  field :word, :type => String
    validates_uniqueness_of :word

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

  def self.create_from_array(array)
    array.each do |item|
      self.create(:word => item)
    end
  end

end
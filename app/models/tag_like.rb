class TagLike
  include Mongoid::Document

  field :total_likes, :type => Integer, :default => 1
  belongs_to :tag, class_name: "Tag", inverse_of: :likes
  belongs_to :liker, class_name: "User", inverse_of: :liked_tags
end
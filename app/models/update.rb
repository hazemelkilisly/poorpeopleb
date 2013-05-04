class Update
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url, :type =>String
  field :title, :type =>String
  field :description, :type =>String

  belongs_to :admin

end

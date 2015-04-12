class Resource
  include Mongoid::Document

  field :type, type: String
  field :yield, type: Integer

end
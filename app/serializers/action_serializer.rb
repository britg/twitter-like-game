class ActionSerializer < ActiveModel::Serializer
  attributes :key, :label, :feedback

  attribute :child_actions

  def child_actions
    object.child_actions
  end

end

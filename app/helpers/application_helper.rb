module ApplicationHelper
  def story_adapter player
    serializer = StorySerializer.new(current_player.story, root: false)
    ActiveModel::Serializer.adapter.new(serializer)
  end
end

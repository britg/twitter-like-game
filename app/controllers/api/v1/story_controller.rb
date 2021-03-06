class Api::V1::StoryController < ApplicationController

  def index
    if !current_player.start_of_input_mark.present?
      LocationProcessor.new(current_player, current_player.location).create_story_events
      current_player.consider!
    end
    render json: current_player.story,
           serializer: StorySerializer,
           root: false
  end

end

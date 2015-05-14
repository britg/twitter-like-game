class Api::V1::StoryController < ApplicationController

  def index
    if !current_player.start_of_input_mark.present?
      LocationProcessor.new(current_player, current_player.location).create_story_events
    end
    render json: current_player,
           serializer: StorySerializer,
           root: nil
  end

end

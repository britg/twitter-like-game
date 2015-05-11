class Api::V1::StoryController < ApplicationController

  def index
    render json: current_player,
           serializer: StorySerializer,
           root: nil
  end

end

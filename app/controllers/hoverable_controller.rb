class HoverableController < ApplicationController

  expose(:likes){ find_likeable.likes }
  def like_counter  
    render partial: "likes/hoverable"
  end
end
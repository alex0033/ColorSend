class BasicPagesController < ApplicationController
  def home
    render :layout => "second_layout"
  end
end

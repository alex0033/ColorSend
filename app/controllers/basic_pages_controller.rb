class BasicPagesController < ApplicationController
  def home
    render :layout => "second_layout"
    flash[:success] = "Yeaj"
  end
end

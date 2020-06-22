class BasicPagesController < ApplicationController
  def home
    if user_signed_in
      redirect_to 
    end
    render :layout => "second_layout"
  end
end

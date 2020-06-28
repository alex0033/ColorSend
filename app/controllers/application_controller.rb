class ApplicationController < ActionController::Base

  private
    # 必ずset user_and_? と一緒に使う
    def check_correct_user
      if @user != current_user
        flash[:danger] = "You are not be authenticated."
        redirect_to root_path
      end
    end

end

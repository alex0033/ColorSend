class ApplicationController < ActionController::Base
  
  private
    # 必ずset user_and_? と一緒に使う
    def check_correct_user
      if @user != current_user
        flash[:alert] = "認証していません"
        redirect_to root_path
      end
    end

end

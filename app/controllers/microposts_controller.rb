class MicropostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @micropost = Micropost.new
  end

  def create
    #この行、micropost_paramsはいらないかも
    @micropost = current_user.microposts.build(micropost_params)

    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Successful creation of micropost"
      redirect_to @micropost
    else
      render 'microposts/new'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @user      = User.find(@micropost.user_id)
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = "Success destroy"
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:image)
    end

end

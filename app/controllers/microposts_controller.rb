class MicropostsController < ApplicationController
  before_action :signed_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  # Note that we haven’t restricted the actions the before filter applies
  # to since it applies to them both by default. If we were to add,
  # say, an index action accessible even to non-signed-in users,
  # we would need to specify the protected actions explicitly:
  def index; end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      # There is one subtlety, though: on failed micropost submission,
      # the Home page expects an @feed_items instance variable,
      # so failed submissions currently break
      # (as you should be able to verify by running your test suite).
      # The easiest solution is to suppress the feed entirely by assigning it an empty array,
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  # This automatically ensures that we find only microposts belonging to the current user.
  # In this case, we use find_by instead of find because the latter raises an exception when
  # the micropost doesn’t exist instead of returning nil.
  # By the way, if you’re comfortable with exceptions in Ruby,
  # you could also write the correct_user filter like this:

  # def correct_user
  # 	@micropost = current_user.microposts.find(params[:id])
  # rescue
  # 	redirect_to root_url
  # end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end

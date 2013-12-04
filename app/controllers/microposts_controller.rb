class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	# Note that we haven’t restricted the actions the before filter applies 
	# to since it applies to them both by default. If we were to add, 
	# say, an index action accessible even to non-signed-in users, 
	# we would need to specify the protected actions explicitly:
	def index
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
	end




	private

	def micropost_params
		params.require(:micropost).permit(:content)
	end
end
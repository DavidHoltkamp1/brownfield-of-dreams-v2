class WelcomeController < ApplicationController
  def index
    @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5) if params[:tag]
    @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
  end
end

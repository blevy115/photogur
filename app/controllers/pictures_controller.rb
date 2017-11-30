class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to sessions_new_url
    end
  end

  def ensure_user_owns_picture
    unless current_user == @picture.user
      flash[:alert] = "You are not the owner of this picture"
      redirect_to sessions_new_url
    end
  end

  def index
    @most_recent_pictures = Picture.most_recent_five
    @pictures=Picture.all
    @pictures_older_month = Picture.created_before(Time.now - 1.month)
    @picture = Picture
  end

  def show

  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user = current_user

    if @picture.save
      redirect_to "/pictures"
    else
      render :new
    end
  end

  def edit

  end

  def update


    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user = current_user

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy

    @picture.destroy
    redirect_to "/pictures"
  end
end

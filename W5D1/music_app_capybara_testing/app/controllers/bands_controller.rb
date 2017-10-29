class BandsController < ApplicationController
  def new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update(band_params)
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def show
    @band = Band.find_by(id: params[:id])
    @albums = @band.albums
    render :show
  end

  def index
    @bands = Band.all.order(:id)
    render :index
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    @band.delete
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end

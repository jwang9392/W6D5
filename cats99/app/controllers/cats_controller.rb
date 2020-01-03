class CatsController < ApplicationController

  def index
    @kittys = Cat.all

    render :index
  end

  def show
    @kitty = Cat.find(params[:id])

    render :show
  end

  def new
    
    @kitty = Cat.new

    render :new
  end

  def create
    
    @kitty = Cat.new(cat_params)
    if @kitty.save
      redirect_to cat_url(@kitty.id)
    else
      render :new, status:422
    end
  end

  def edit
    @kitty = Cat.find(params[:id])
    render :edit
  end

  private

  def cat_params
    params.require(:cats).permit(:birth_date, :color, :name, :sex, :description)
  end
end

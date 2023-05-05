class ThemeController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  before_action :set_theme, only: [:show, :update, :destroy]
  
  def index
    render json: Theme.all
  end

  def show
    render json: @theme
  end

  def create
    @theme = Theme.new(theme_params)
    
    if @theme.save
      render json: @theme, status: :created
    else
      render json: @theme.error, status: :failed
    end
  end

  def update
    if @theme.update(theme_params)
      render json: @theme
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @theme.destroy
    head :no_content
  end

  def test
    devise_api_token = current_devise_api_token
    if devise_api_token
      render json: {message: "you are in " + devise_api_token.resource_owner.email}, status: :ok
    else
      render json: {message: "you are not logged in"}, status: :ok
    end
  end

  private

  def set_theme
    @theme = Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:title, :description)
  end

end

class ThemeController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  before_action :set_theme, only: [:show, :update, :destroy]
  
  def index
    if params[:ids].present? && params[:ids] != ['']
      @themes = Theme.all.joins(:tags).where(tags: { id: params[:ids] }).distinct
    else
      @themes = Theme.all
    end
    render json:  @themes, include: :tags
  end

  def show
    render json: @theme
  end

  def create
    if(current_devise_api_token.resource_owner.type == 'Supervisor')
      @theme = Theme.new(theme_params)
  
      @theme.supervisor = current_devise_api_token.resource_owner

      if @theme.save
        render json: @theme, status: :created
      else
        render json: @theme.error, status: :failed
      end
    else
      render json: {message: "No Permission!"}, status: :failed
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

  def themes_from_supervisor
    if params[:id].present? && params[:id] != ''
      if params[:ids].present? && params[:ids] != ['']
        @themes = Supervisor.find(params[:id]).themes
                            .joins(:tags).where(tags: { id: params[:ids] }).distinct
      else
        @themes = Supervisor.find(params[:id]).themes
      end
    else
      if(current_devise_api_token.resource_owner.type == 'Supervisor')
        if params[:ids].present? && params[:ids] != ['']
          @themes = current_devise_api_token.resource_owner.themes
                              .joins(:tags).where(tags: { id: params[:ids] }).distinct
        else
          @themes = current_devise_api_token.resource_owner.themes
        end
      end
    end
    
    render json:  @themes, include: :tags
  end

  private

  def set_theme
    @theme = Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:title, :description, tag_ids: [])
  end

end
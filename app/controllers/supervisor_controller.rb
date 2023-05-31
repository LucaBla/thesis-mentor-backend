class SupervisorController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  #before_action :set_theme, only: [:show, :update, :destroy]
  
  def index
    if params[:ids].present? && params[:ids] != ['']
      #@supervisors = Supervisor.all.joins(:tags).where(tags: { id: [1, 2] })
      @supervisor = Supervisor.all.joins(:tags).where(tags: { id: params[:ids] }).distinct
    else
      @supervisor = Supervisor.all
    end

    render json: @supervisor, include: :tags
  end

  def show
    if(current_devise_api_token.resource_owner.type == 'Supervisor')
      render json: current_devise_api_token.resource_owner, include: :tags, status: :ok
    else render json: 'test', status: :ok
    end
  end
end

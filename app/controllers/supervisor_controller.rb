class SupervisorController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  #before_action :authenticate_devise_api_token!
  #before_action :set_theme, only: [:show, :update, :destroy]
  
  def index
    puts 'test'
    puts params[:ids] == ['']
    if params[:ids].present? && params[:ids] != ['']
      #@supervisors = Supervisor.all.joins(:tags).where(tags: { id: [1, 2] })
      @supervisor = Supervisor.all.joins(:tags).where(tags: { id: params[:ids] }).distinct
    else
      @supervisor = Supervisor.all
    end

    render json: @supervisor, include: :tags
  end
end

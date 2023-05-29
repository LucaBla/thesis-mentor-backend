class SupervisorController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  #before_action :set_theme, only: [:show, :update, :destroy]
  
  def index
    render json: Supervisor.all, include: :tags
  end
end

class SupervisorController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  #before_action :set_theme, only: [:show, :update, :destroy]
  
  def index
    if params[:ids].present? && params[:ids] != ['']
      #@supervisors = Supervisor.all.joins(:tags).where(tags: { id: [1, 2] })
      @supervisor = Supervisor.all.joins(:tags).where(tags: { id: params[:ids] }).distinct
    elsif params[:name].present? && params[:name] != ['']
      @supervisor = Supervisor
                    .where("LOWER(first_name) LIKE :name OR 
                    LOWER(last_name) LIKE :name OR
                    (LOWER(first_name) || ' ' || LOWER(last_name)) LIKE :name", 
                    name: "%#{params[:name].downcase}%")
    else
      @supervisor = Supervisor.all
    end

    render json: @supervisor.where.not(id: current_devise_api_token.resource_owner.id), include: :tags
  end

  def show
    if(current_devise_api_token.resource_owner.type == 'Supervisor')
      render json: current_devise_api_token.resource_owner, include: :tags, status: :ok
    else render json: 'test', status: :ok
    end
  end

  def add_tags
    if(current_devise_api_token.resource_owner.type == 'Supervisor')
      tag_ids = tag_params[:ids]
      tags = Tag.where(id: tag_ids)
      current_devise_api_token.resource_owner.tags.push(tags)

      render json: current_devise_api_token.resource_owner, include: :tags, status: :ok
    else
      render json: { error: 'No permission!' }, status: :forbidden
    end
  end

  def remove_tags
    if(current_devise_api_token.resource_owner.type == 'Supervisor')
      tag_ids = tag_params[:ids]
      tags = Tag.where(id: tag_ids)
      current_devise_api_token.resource_owner.tags.delete(tags)

      render json: current_devise_api_token.resource_owner, include: :tags, status: :ok
    else
      render json: { error: 'No permission!' }, status: :forbidden
    end
  end

  private
  def tag_params
    params.require(:tags).permit(ids: [])
  end
end

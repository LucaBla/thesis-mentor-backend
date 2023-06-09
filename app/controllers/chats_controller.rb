class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!
  before_action :set_chat, only: %i[ show update destroy ]

  # GET /chats
  def index
    if params[:status_ids].present? && params[:status_ids] != ['']
      @chats = current_devise_api_token.resource_owner.chats.joins(:status).where(status: { id: params[:status_ids] }).distinct
    else
      @chats = current_devise_api_token.resource_owner.chats.all
    end

    if params[:billing_status_ids].present? && params[:billing_status_ids] != ['']
      @chats = @chats.joins(:billing_status).where(billing_status: { id: params[:billing_status_ids] }).distinct
    end

    render json: @chats.includes(:messages).order("messages.created_at DESC"), include: [:theme, :status, :billing_status, :supervisor, :student]
  end

  def second_chats_index
    @chats = current_devise_api_token.resource_owner.second_chats

    render json: @chats.includes(:messages).order("messages.created_at DESC"), include: [:theme, :status, :billing_status, :supervisor, :student]
  end

  # GET /chats/1
  def show
    render json: @chat, include: [:theme, :status, :billing_status, :supervisor, :student, :messages]
  end

  # POST /chats
  def create
    @chat = Chat.where(supervisor_id: chat_params[:supervisor_id], 
                       student: current_devise_api_token.resource_owner,
                       theme_id: chat_params[:theme_id])
    if @chat == []
      @chat = Chat.new(chat_params)

      @chat.student = current_devise_api_token.resource_owner

      if @chat.save
        render json: @chat, status: :created, location: @chat
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
    else  
      render json: @chat.first
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    if current_devise_api_token.resource_owner.type == "Supervisor"
      @chat.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:supervisor_id, :student, :status_id, :billing_status_id, :theme_id,
                                   :second_supervisor_id)
    end
end

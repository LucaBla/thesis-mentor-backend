class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  #before_action :authenticate_devise_api_token!
  before_action :set_tag, only: %i[ show update destroy ]

  # GET /tags
  def index
    #@tags = Tag.all
    if params[:title].present?
      @tags = Tag.where("LOWER(title) LIKE ?", "%#{params[:title].downcase}%")
    else
      @tags = Tag.all
    end

    render json: @tags
  end

  # GET /tags/1
  def show
    render json: @tag
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tags).permit(:title)
    end
end

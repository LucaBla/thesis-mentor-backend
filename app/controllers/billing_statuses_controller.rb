class BillingStatusesController < ApplicationController
  before_action :set_billing_status, only: %i[ show update destroy ]

  # GET /billing_statuses
  def index
    @billing_statuses = BillingStatus.all

    render json: @billing_statuses
  end

  # GET /billing_statuses/1
  def show
    render json: @billing_status
  end

  # POST /billing_statuses
  def create
    @billing_status = BillingStatus.new(billing_status_params)

    if @billing_status.save
      render json: @billing_status, status: :created, location: @billing_status
    else
      render json: @billing_status.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /billing_statuses/1
  def update
    if @billing_status.update(billing_status_params)
      render json: @billing_status
    else
      render json: @billing_status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /billing_statuses/1
  def destroy
    @billing_status.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing_status
      @billing_status = BillingStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def billing_status_params
      params.fetch(:billing_status, {})
    end
end

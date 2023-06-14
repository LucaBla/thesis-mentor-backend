class BillingStatusesController < ApplicationController
  before_action :set_billing_status, only: %i[ show update destroy ]

  # GET /billing_statuses
  def index
    if params[:title].present?
      @billing_status = BillingStatus.where("LOWER(title) LIKE ?", "%#{params[:title].downcase}%")
    else
      @billing_status = BillingStatus.all
    end

    render json: @billing_status
  end

  # GET /billing_statuses/1
  def show
    render json: @billing_status
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
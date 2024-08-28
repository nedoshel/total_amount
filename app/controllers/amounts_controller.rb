class AmountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    total_amount = AmountsService.new(token: params[:token], value: params[:value]).perform

    render json: { total_amount: total_amount }
  end
end

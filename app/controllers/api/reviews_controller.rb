class Api::ReviewsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def create
    review_request = ReviewRequest.new(review_request_params.merge(user_id: current_user.id))
    if review_request.save
      render json: { review_request: review_request.to_json }, status: 200
    else
      head :forbidden
    end
  end


  private

  def review_request_params
    params.require(:review_request).permit(:title, :detail, :value)
  end

end

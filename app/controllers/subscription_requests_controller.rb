class SubscriptionRequestsController < ApplicationController
  def create
    @subscription_request = SubscriptionRequest.new(subscription_params)

    if @subscription_request.save
      flash[:success] = "Thanks! Please check your email to proceed."
      redirect_to root_path
    else
      flash[:error] = "Looks like there were a few problems with your request. Try again, please?"
      render "site/index", status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params
      .require(:subscription_request)
      .permit(:email)
  end
end

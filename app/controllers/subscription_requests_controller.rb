class SubscriptionRequestsController < ApplicationController
  before_filter :already_subscribed?, only: [ :create ]

  def create
    @subscription_request = SubscriptionRequest.new(subscription_params)

    if @subscription_request.save
      SubscriptionMailerJob.perform_later(@subscription_request.id)
      flash[:success] = "Thanks! Please check your email to proceed."
      redirect_to root_path
    else
      flash[:error] = "Looks like there were a few problems with your request. Try again, please?"
      render "site/index", status: :unprocessable_entity
    end
  end

  def confirm
    @subscription_request = SubscriptionRequest.find_by(token: params[:id])
    @subscription_request.confirm!
    flash[:success] = "You've been subscribed to the list!"
    redirect_to root_path
  end

  private

  def subscription_params
    params
      .require(:subscription_request)
      .permit(:email)
  end

  def already_subscribed?
    if Subscription.find_by(email: subscription_params[:email]).present?
      flash[:notice] = "Thanks! Looks like you're already subscribed!"
      redirect_to root_path
    end
  end
end

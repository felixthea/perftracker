class ExpectationsController < ApplicationController
  before_action :authenticate_user! # Ensures the user is logged in

  def index
    @expectations = Expectation.joins(:user).where(users: { email: current_user.email })
    @expectation = Expectation.new
  end

  def create
    @expectation = current_user.expectations.new(expectation_params)

    if @expectation.save
      flash[:notice] = "Expectation was successfully created."
      redirect_to expectations_path
    else
      Rails.logger.error @expectation.errors.full_messages.to_sentence
      flash[:alert] = "There was an error creating the expectation."
      @expectations = Expectation.all
      render :index
    end
  end

  private

  def expectation_params
    params.require(:expectation).permit(:text)
  end
end

class ExpectationsController < ApplicationController
  def index
    @expectations = Expectation.all
    @expectation = Expectation.new
  end

  def create
    puts "params"
    puts params
    @expectation = Expectation.new(
      text: params["expectation"]["text"]
    )

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
end

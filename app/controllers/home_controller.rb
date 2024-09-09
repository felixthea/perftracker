class HomeController < ApplicationController
  def index
    puts "user signed in?"
    puts user_signed_in?
  end
end

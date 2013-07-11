class HomesController < ApplicationController
  def show
    if user_signed_in?
      flash.keep
      redirect_to questions_path and return
    end
  end
end

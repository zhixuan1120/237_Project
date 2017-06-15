class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to sendmessage_path
    else
      @user = User.new
    end
  end

  def about
  end

  def contact
  end
end

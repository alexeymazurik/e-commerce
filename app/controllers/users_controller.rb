class UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to '/supplies'
    end

  end
end
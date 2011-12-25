class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @card = @user.cards.first
    redirect_to cards_path(@card)
  end  
end
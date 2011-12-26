class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @card = @user.cards.first
    redirect_to card_path(@card)
  end  
end
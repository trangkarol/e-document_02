class CoinsController < ApplicationController
  before_action :list_friend_request, only: [:new]
  before_action :list_friends_accept, only: [:new]

  def number_coins
    @coin = Coin.find_by_id params[:coin_id]
    if @coin
      render json: {coin: @coin, status: true}
    else
      render json: {status: false}
    end
  end
end

class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index,:create]
  before_action :move_to_toppage, only: [:index]
  
  def index
    @buyer_shipping_address = BuyerShippingAddress.new
  end
  
  def create
    @buyer_shipping_address = BuyerShippingAddress.new(buyer_params)
    if @buyer_shipping_address.valid?
      pay_item
      @buyer_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  
  private

  def buyer_params
    params.require(:buyer_shipping_address).permit(:prefecture_id,:municipality,:address,:building_name,:post_code,:telephone_number, :price).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: buyer_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def move_to_toppage
    unless @item.buyer == nil && current_user.id != @item.user_id
      redirect_to root_path
    end
  end

end

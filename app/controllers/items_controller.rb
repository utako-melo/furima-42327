class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :redirect_unless_seller, only: [:edit, :update]

  

  def index
    @items = Item.all.order('created_at desc')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_seller
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_costs_id,
                                 :prefecture_id, :delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end
end

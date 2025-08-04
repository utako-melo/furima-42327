class ItemsController < ApplicationController
  def index
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_costs_id,
                                 :prefecture_id, :delivery_time_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end

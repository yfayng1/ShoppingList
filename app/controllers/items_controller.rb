class ItemsController < ApplicationController
def index
  @todo   = Item.where(:done => false)
  @item   = Item.new
  @lists  = List.all
  @list   = List.new

  respond_to do |format|
    format.html
    format.json do
      render :json => {:items => Item.all.map(&:to_json) }
    end
  end
end

def create
  @list = List.find(params[:list_id])
  raw_params = params[:item].is_a?(String) ? JSON.parse(params[:item]) : params[:item]
  item_params = ActionController::Parameters.new(raw_params)
  @item = @list.items.new(item_params.permit(:name))
  if @item.save
    status = "success"
    flash[:notice] = "Your item was created."
  else
    status = "failure"
    flash[:alert] = "There was an error creating your item."
  end
  respond_to do |format|
    format.html do
      redirect_to(list_items_url(@list))
    end
    format.json do
      render :json => {:status => status, :item => @item.to_json}
    end
  end
end

def update
  @list = List.find(params[:list_id])
  @item = @list.items.find(params[:id])

  respond_to do |format|
    if @item.update_attributes(item_attributes)
      format.html { redirect_to( list_items_url(@list), :notice => 'item was successfully updated.') }
    else
      format.html { render :action => "edit" }
    end
  end
end

def destroy
  @list = List.find(params[:list_id])
  @item = Item.find(params[:id])
  @item.destroy

  respond_to do |format|
    format.html { redirect_to(list_items_url(@list)) }
  end
end

private

def item_attributes
  params.require(:item).permit(:name, :done, :list_id)
end
end
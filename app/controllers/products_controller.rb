class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_category_product, only: [:show, :update, :destroy]


  def index
    json_response(@category.products)
  end


  def show
    json_response(@product)
  end


  def create
    @category.products.create!(product_params)
    json_response(@category, :created)
  end


  def update
    @product.update(product_params)
    head :no_content
  end


  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.permit(:name, :price, :date_added)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_category_product
    @product = @category.products.find_by!(id: params[:id]) if @category
  end
end

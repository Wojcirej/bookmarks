# frozen_string_literal: true

module Web
  class CategoriesController < Web::BaseController
    before_action :set_category, only: %i[show destroy]
    def show
      @links = []
    end

    def new
      @category = Category.new
      @parent_id = params[:parent_id]
    end

    def create
      @category = Category.add_new(category_params)
      if @category.persisted?
        redirect_to root_path, notice: 'Category has been added successfully'
      else
        flash[:alert] = @category.errors.values.flatten.join('<br>').html_safe
        render :new
      end
    end

    def destroy
      @category.destroy
      binding.pry
      redirect_to root_path,
                  notice:
                    "Category #{@category.name} has been removed successfully"
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :parent_id)
    end
  end
end

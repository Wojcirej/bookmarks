# frozen_string_literal: true

module Web
  class LinksController < Web::BaseController
    before_action :set_category

    def new
      @link = Link.new
    end

    def create
      @link = Link.add_new_to_category(link_params, @category.id)
      if @link.persisted?
        redirect_to(
          category_path(@category),
          notice:
            "Bookmark '#{@link.name}' has been added into category '#{
              @category.name
            }'"
        )
      else
        flash[:alert] = @link.errors.values.flatten.join('<br>').html_safe
        render 'web/categories/show'
      end
    end

    def destroy
      @link = @category.links.find(params[:id])
      @link.destroy
      redirect_to category_path(@category),
                  notice: "Link '#{@link.name}' has been removed successfully"
    end

    private

    def set_category
      @category = Category.find(params[:category_id])
    end

    def link_params
      params.require(:link).permit(:name, :description, :url)
    end
  end
end

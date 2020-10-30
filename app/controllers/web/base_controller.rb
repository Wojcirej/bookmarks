# frozen_string_literal: true

module Web
  class BaseController < ApplicationController
    before_action :set_categories

    def index; end

    protected

    def set_categories
      @categories = Category.list
    end
  end
end

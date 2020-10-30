# frozen_string_literal: true

class Category < ApplicationRecord
  UUID_FORMAT = /\A[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}/i
    .freeze

  has_ancestry(primary_key_format: UUID_FORMAT)
  validates :name,
            presence: { message: 'Please specify category name' },
            length: { maximum: 30 }
  validates_uniqueness_of :name, message: 'Category exists'

  default_scope -> { order('created_at ASC') }

  def self.add_new(params)
    Category.create(name: params[:name], parent_id: params[:parent_id])
  end

  def self.list(options = {}, hash = nil)
    hash ||= arrange(options)

    arr = []
    hash.each do |node, children|
      arr << node
      arr += list(options, children) unless children.empty?
    end
    arr
  end
end

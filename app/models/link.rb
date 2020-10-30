class Link < ApplicationRecord
  belongs_to :category

  validates :name,
            presence: { message: 'Please specify link name' },
            length: { maximum: 60 }
  validates_presence_of :category_id

  default_scope -> { order('created_at ASC') }

  def self.add_new_to_category(params, category_id)
    Link.create(
      name: params[:name],
      description: params[:description],
      url: params[:url],
      category_id: category_id
    )
  end
end

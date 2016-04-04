class List < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name, on: :create, message: "must be unique"

  has_many :items , dependent: :destroy

  def done_items
    items.where(done: true).order("updated_at DESC")
  end

end
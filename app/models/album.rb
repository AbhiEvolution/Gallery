class Album < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_photo
  has_many_attached :photos
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  validates :cover_photo, :presence => true
  validates :photos, :presence => true
  has_many :likes, dependent: :destroy
  validates :title, :length => {
                      :minimum => 3,
                      :maximum => 10,
                      :tokenizer => lambda { |str| str.scan(/\w+/) },
                      :too_short => "must have at least %{count} words",
                      :too_long => "must have at most %{count} words",
                    }
  validates :description, :length => {
                            :minimum => 3,
                            :maximum => 30,
                            :tokenizer => lambda { |str| str.scan(/\w+/) },
                            :too_short => "must have at least %{count} words",
                            :too_long => "must have at most %{count} words",
                          }

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end
end

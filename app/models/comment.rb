class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :content, presence: true

  scope :ordered_comments, -> { order(created_at: :desc) }
end

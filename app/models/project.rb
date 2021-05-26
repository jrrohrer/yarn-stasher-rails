class Project < ApplicationRecord
  belongs_to :user
  has_many :yarns
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
end

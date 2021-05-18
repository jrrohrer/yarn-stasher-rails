class Project < ApplicationRecord
  belongs_to :user
  has_many :yarns
  has_many :comments
  has_many :users, through: :comments
end

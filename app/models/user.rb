class User < ApplicationRecord
  has_many :yarns
  has_many :projects
  has_many :comments
  has_many :commented_projects, through: :comments, source: 'project'
  # has_many :projects, through: :comments

  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
end

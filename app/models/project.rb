class Project < ApplicationRecord
  belongs_to :user
  has_many :yarns
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  validates :title, presence: true

  # finds the project with the highest humber of comments
  scope :popular_project, -> { joins(:comments).group(:project_id).order('COUNT(comments.id) DESC').limit(1) }
  # joins projects table to comments table, groups comments by project ID, counts the comments for each project ID and puts them in descending order, then returns only the first one (the one with the highest number of comments)

  # finds the 5 most recent projects
  scope :recent_projects, -> { order(created_at: :desc).limit(5) }
  # orders projects by their created_at date/time in descending order, then returns only the first 5 (the 5 most recently created projects)

  #def brand_and_colorway
    #"#{brand_name} - #{colorway}"
  #end
end

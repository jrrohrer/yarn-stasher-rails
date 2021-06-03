class User < ApplicationRecord
  has_many :yarns
  has_many :projects
  has_many :comments
  has_many :commented_projects, through: :comments, source: 'project'
  # has_many :projects, through: :comments

  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  # scope method for finding the user who has made the most comments
  scope :top_commenter, -> { joins(:comments).group(:user_id).order('COUNT(comments.id) DESC').limit(1) }
  # joins users table to comments table, groups comments by user ID, counts the comments made by each user and puts them in descending order, then returns only the first one (the one with the highest number of comments)

  # method for creating/logging in a user via google oauth, called in the sessions controller
  def self.create_by_oauth(auth)
    self.find_or_create_by(email: auth[:info][:email]) do |u|
      u.password = SecureRandom.hex #sets a random password
      u.username = auth[:info][:name]
      u.email = auth[:info][:email]
    end
  end

end

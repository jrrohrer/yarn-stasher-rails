# Yarn Stasher 2.0 (This time with Rails)

## Models

[x]* User
	-Attributes
    -PK: user_id
		-username
		-email
		-password
	-Associations
		-has_many :yarns
		-has_many :projects
		-has_many :comments
		-has_many :projects, through: :comments (alias as 'commented_projects')
	-Validations
		-has_secure_password

[x]* Yarn 
	-Attributes
    -PK: yarn_id
    -FK: user_id 
    -FK: project_id (when making migration, make sure this isn't marked null: false!!! Yarns can exist without being linked to a Project.)
		-brand_name
		-colorway
		-fiber
		-weight
		-yardage
		-quantity
	-Associations
		-belongs_to :user
		-belongs_to :project
	-Validations
	
[x]* Project
	-Attributes
    -PK: project_id
    -FK: user_id
		-title
		-pattern_name
		-designer
		-craft
		-tool_size
	-Associations
		belongs_to :user
		has_many :yarns
		has_many :comments
		has_many :users, through: :comments
	-Validations

[x]* Comments (MAIN JOIN)
	-Attributes
		content
	-Associations
		belongs_to :user
		belongs_to :project
	-Validations

## User Stories

* Signup/Login/Logout
	- A guest can create a profile by signing in with OAuth or name/password/email
	- A user can log in and land on their personal show page
	- A user can log out 
	- A guest will not be able to see content without logging in
	- A guest will not be able to comment on a project without logging in
	
* Yarns
	- A user can create a new yarn
	- A user can edit an existing yarn
	- A user can sort their yarns by column in the view
	- A user can see what projects their yarn is attached to
	- A user can update a yarn to remove it from a project
	- A user can view other users' yarn stash, but cannot add or change that user's yarns
	
* Projects
	- A user can create a new project
	- A user can update an existing project
	- A user can add their existing yarns to a project
	- A user can add a new yarn when creating a project?
	- A user can view other users' projects
	
* Comments
	- A user can comment on their own projects
	- A user can comment on other users' projects
	
Resources:
https://github.com/hansenjl/MyBlog (Jen Hansen's MyBlog repo)

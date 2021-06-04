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

## Methods From ActiveRecord Associations
  * belongs_to
    association
    association=(associate)
    build_association(attributes = {})
    create_association(attributes = {})
    create_association!(attributes = {})
    reload_association

  * has_many
    collection
    collection<<(object, ...)
    collection.delete(object, ...)
    collection.destroy(object, ...)
    collection=(objects)
    collection_singular_ids
    collection_singular_ids=(ids)
    collection.clear
    collection.empty?
    collection.size
    collection.find(...)
    collection.where(...)
    collection.exists?(...)
    collection.build(attributes = {})
    collection.create(attributes = {})
    collection.create!(attributes = {})
    collection.reload

  * has_many :through
    collection
    collection=(obj, obj, ...)
    collection_ids
    collection_ids=(id, id, ...)
    collection<<
    collection.push
    collection.concat
    collection.build(attributes)
    collection.create(attributes)
    collection.create!(attributes)
    collection.size
    collection.length
    collection.count
    collection.sum(*args)
    colection.empty?
    collection.clear
    collection.delete(obj, obj, ...)
    collection.delete_all
    collection.destroy(obj, obj, ...)
    collection.destroy_all
    collection.find(*args)
    collection.exists?
    collection.distinct
    collection.reset
    collection.reload

## Progress
  5/18
    - created resources for all 4 models
    - added associations to all 4 models
    - migrated database
    - added seed data
    - tested ActiveRecord associations in Rails console to make sure they work

  5/19
    - added sessions controller & sessions views folder
    - added root route 'sessions#home' and accompanying view
    - added validations to User model
    - built out signup functionality
    - built out login functionality

  5/20
    - built out logout functionality
      - added nav to application layout

  5/21
    - added flash message to sessions#create and sessions/new for login errors
    - added error handling to sign up page
    - added form for creating a new yarn
    - added a table of yarns to user's show page
    - added data display to individual yarn show page

  5/24
    - fixed create yarn form (new yarns weren't being created if they weren't associated to a project)
    - added projects/new page w/form
    - added projects/id/show page
    - added projects/id/edit page w/form
    - added projects/ index page
    - added nested routing: comments under projects. Shallow only
    - added comments/new form
    - started comments/id/show page

    - thinking about nested routes:
      - nest yarns under projects?
        - would give me route(s) for looking at yarns associated to a project: /projects/:id/yarns
        - or I could just link back to the individual yarn show pages? Or just display this data on the project's show page?
      - nest comments under projects?
        - would give me routes for commenting, since comments can't exist without being owned by both a project and a user:
          - '/projects/:id/comments (all comments for a project)
          - '/projects/:id/comments/new (create a new comment for a project)
          - '/projects/:id/comments/:id (view an individual comment)
          - '/projects/:id/comments/edit (edit an existing comment)

  5/25
    - sorted out comments#create controller action
    - comments#show controller action and view
    - comments#index controller action and view (shows all comments for a particular project...might not keep this. I kind of want all the comments for a project to show up on the project show page)
    - added a link to projects#show page to view individual comments
    - thinking of adding a feature where only part of a long comment is visible on the project#show page
    - also only showing the 5 latest comments, then linking to comments#index if someone wants to see all of the comments on a project.

  5/26
    - added form and controller actions for editing a comment
    - added delete controller action & view link for comments
    - added delete controller action & view link for projects (if a project is deleted, all associated comments are also removed from the DB)
    - added delete controller action & view link for yarns

  5/28
    - added an error partial to render in the new/edit views for all classes 
    - updated new yarn form to also create a new project
    - made the creation of a project when making a new yarn optional
    - added the option to associate an existing yarn to an existion project in the yarn edit form

  6/1
    - converted Users#show into the user's profile page (also where new users will land after creating their account)
    - created Users#index as a home page post-login
      - This is where info from scope methods will be displayed
    - added scope method for finding the project with the most comments
    - created scope method for finding the project with the most comments
  
  6/2
    - displayed data returned from Project scope methods on users#index page
    - created scope method for finding the user with the most comments
    - displayed data returned from User scope method on users#index page
    - created scope method for finding the most popular yarn brand
    - displayed data returned from Yarn scope method on users#index page
    - renamed the users#index route so that the url displays as '/home' rather than '/users'
    - added google oauth login! (what a pain -_-' )
  
  6/3 
    - added before action to require that users are logged in to view any page other than home, login, or signup
    - refactored users#show so that all data is collected through the user model. Now all the info on the page belongs to the user whose id is in the URL, rather than whoever the current user is. This way, users can view other users' profile pages
    - added protections so only the user who created a yarn can edit or delete it.
    - added protections so only the user who created a project can edit or delete it.
    - minor view refactoring for clarity
    - added links to user profiles in the project views & comments section
    - added some basic styling (pulled from previous iteration of this project)
    - displayed user's projects as info cards on their profile page
  
  6/4 
    - screen recording session
      - added profile photo to user model using Active Storage
    - refactoring session
    


Next time:
  - validations:
    
  - What do I want to see on a user's profile page? 
    [x] Username
    [x] Profile picture?
    [x] List of the projects they own w/ links to project show pages (displayed as cards?)
    [x] Table containing the user's yarn stash

  - styling!

REFACTORING THOUGHTS
  - new/edit forms should be made into partials for yarns, projects, and comments
  - 'set_object' methods in controllers


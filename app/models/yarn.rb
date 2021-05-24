class Yarn < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true 
  # a yarn can be created without associating it to a project, but if it is associated to a project, it should have a project foreign key
  accepts_nested_attributes_for :project
  # so that a project can be created from the New Yarn page-- yarn and associated project can be created using the same form. 
end

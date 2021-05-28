class Yarn < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true 
  # a yarn can be created without associating it to a project, but if it is associated to a project, it should have a project foreign key
  accepts_nested_attributes_for :project, reject_if: :all_blank
  # so that a project can be created from the New Yarn page-- yarn and associated project can be created using the same form. reject_if proc will be called with each hash of attributes submitted by the form. if the proc returns false, AR will not build the associated object for that hash. In this case, a project will not be built if all the fields on the nested form are blank

  validates :brand_name, :quantity, presence: true

end

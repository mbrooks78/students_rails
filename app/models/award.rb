class Award < ActiveRecord::Base

  # every award is linked to a student, through student_id
  belongs_to :student

  validates_existence_of :student



end

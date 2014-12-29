class Course < ActiveRecord::Base

  # A student can have many courses, a course can have many students
  has_and_belongs_to_many :students
end

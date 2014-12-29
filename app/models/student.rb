class Student < ActiveRecord::Base

  # a student can have many awards
  has_many :awards, dependent: :destroy

  # a student can have many courses, a course can have many students
  has_and_belongs_to_many :courses

  validates_inclusion_of :date_of_birth, :in => Date.civil(1900, 1, 1) .. Date.today,
                         :message => "must be between January 1st, 1900 and today"

  def name
    given_name + " " + family_name
  end

  def enrolled_in?(course)
    self.courses.include?(course)
  end

  def unenrolled_courses
    Course.all - self.courses
  end
end

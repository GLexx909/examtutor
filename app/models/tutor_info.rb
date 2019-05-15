class TutorInfo < ApplicationRecord
  has_one_attached :initial_profile_photo
  has_one_attached :profile_photo
  has_many_attached :diploms
  has_many_attached :diploms_perekval
  has_many_attached :diploms_povishkval

  def all_diploms
    diploms + diploms_perekval + diploms_povishkval
  end
end

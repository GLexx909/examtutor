class TutorInfosController < ApplicationController
  before_action :tutor_info, only: [:index, :diplomas]

  authorize_resource

  def index
  end

  def site_features
  end

  def diplomas
  end

  def update
    if can?(:manage, :all)
      delete_photos_if_need
      tutor_info.update(tutor_info_params)
      redirect_to request.referer
    else
      head :forbidden
    end
  end

  private

  def tutor_info
    @tutor_info ||= TutorInfo.first ? TutorInfo.first : TutorInfo.create
  end

  def description
    tutor_info.description
  end

  def delete_photos_if_need
    ActiveStorage::Attachment.find(tutor_info.initial_profile_photo.id).purge if params[:tutor_info][:initial_profile_photo] && tutor_info.initial_profile_photo.attached?
    ActiveStorage::Attachment.find(tutor_info.profile_photo.id).purge if params[:tutor_info][:profile_photo] && tutor_info.profile_photo.attached?
  end

  def tutor_info_params
    params.require(:tutor_info).permit( :initial_profile_photo, :profile_photo, :description, diploms: [], diploms_perekval: [], diploms_povishkval: [])
  end
end

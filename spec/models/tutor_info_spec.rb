require 'rails_helper'

RSpec.describe TutorInfo, type: :model do
  it 'have many attached diploms' do
    expect(TutorInfo.new.diploms).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it 'have many attached diploms_perekval' do
    expect(TutorInfo.new.diploms_perekval).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it 'have many attached diploms_povishkval' do
    expect(TutorInfo.new.diploms_povishkval).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it 'have one attached initial_profile_photo' do
    expect(TutorInfo.new.initial_profile_photo).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it 'have one attached profile_photo' do
    expect(TutorInfo.new.profile_photo).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end

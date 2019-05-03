require 'rails_helper'

RSpec.describe NotificationsForAllJob, type: :job do
  let(:service) { double('Service::SendNotificationService') }
  let(:title) { 'Title' }
  let(:link) { 'root_path' }
  let(:abonent) { create :user }
  let(:type) { 'message' }

  before do
    allow(Services::SendNotificationService).to receive(:new).and_return(service)
  end

  it 'calls Service::SendNotificationService#send' do
    expect(service).to receive(:send)
    NotificationsForAllJob.perform_now(title, link, abonent, abonent, type)
  end
end

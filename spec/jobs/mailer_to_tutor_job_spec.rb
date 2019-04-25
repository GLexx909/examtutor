require 'rails_helper'

RSpec.describe MailerToTutorJob, type: :job do
  let(:service) { double('Service::MailToTutorService') }
  let(:author) { create :user }
  let(:message) { 'message' }

  before do
    allow(Services::MailToTutorService).to receive(:new).and_return(service)
  end

  it 'calls Service::MailToTutorService#send_mail' do
    expect(service).to receive(:send_mail)
    MailerToTutorJob.perform_now(message, author)
  end
end

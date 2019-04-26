require 'rails_helper'

RSpec.describe WeeklyDigestJob, type: :job do
  let(:service) { double('Service::WeeklyDigestService') }

  before do
    allow(Services::WeeklyDigestService).to receive(:new).and_return(service)
  end

  it 'calls Service::WeeklyDigestService#send_digest' do
    expect(service).to receive(:send_digest)
    WeeklyDigestJob.perform_now
  end
end

require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'GET #index' do
    context 'if valid search query' do
      let(:sphinx_service) { double(Services::SearchSphinxService) }
      let(:user) { create :user }

      before do
        login(user)
        allow(Services::SearchSphinxService).to receive(:new).and_return(sphinx_service)
      end

      it 'searches for result' do
        expect(sphinx_service).to receive(:find).with('Везде', 'test', '1')
        get :index, params: {category: 'Везде', search: 'test', page: '1'}
      end

      it "should render :index" do
        allow(sphinx_service).to receive(:find).with('Везде', 'test', '1').and_return([])
        get :index, params: {category: 'Везде', search: 'test', page: '1'}

        expect(response).to render_template(:index)
      end
    end

    context 'if invalid (blank) search query' do
      it 'redirect to root_path' do
        get :index, params: {category: 'Везде', search: '', page: '1'}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

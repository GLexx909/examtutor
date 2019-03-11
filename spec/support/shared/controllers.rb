shared_examples_for 'To render index view' do
  it 'render index view' do
    expect(response).to render_template :index
  end
end

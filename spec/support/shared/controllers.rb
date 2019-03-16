shared_examples_for 'To render index view' do
  it 'render index view' do
    expect(response).to render_template :index
  end
end

shared_examples_for 'To render show view' do
  it 'render show view' do
    expect(response).to render_template :show
  end
end

shared_examples_for 'To render create.js view' do
  it 'render create.js view' do
    post :create, params: params, format: :js
    expect(response).to render_template :create
  end
end

shared_examples_for 'To render destroy.js view' do
  it 'deletes the object' do
    delete :destroy, params: { id: resource }, format: :js
    expect(response).to render_template :destroy
  end
end

shared_examples_for 'To save a new object' do
  it 'saves a new object in the database' do
    expect { post :create, params: params, format: :js }.to change(object_class, :count).by(1)
  end

  it 'according to the author of the object' do
    post :create, params: params, format: :js
    expect(assigns(object.to_sym).author).to eq user
  end
end

shared_examples_for 'To assigns the request resource to @resource' do
  it 'assigns the requested resource to @resource' do
    expect(assigns(instance.to_sym)).to eq resource
  end
end

shared_examples_for 'To delete the object' do
  it 'deletes the object' do
    expect { delete :destroy, params: { id: object }, format: :js }.to change(object_class, :count).by(-1)
  end
end

shared_examples_for 'To not delete the object' do
  it 'deletes the object' do
    expect { delete :destroy, params: { id: object }, format: :js }.to_not change(object_class, :count)
  end
end

shared_examples_for 'DELETE to render status 403' do
  it 'render status 403' do
    delete :destroy, params: { id: object }, format: :js
    expect(response).to have_http_status 403
  end
end

shared_examples_for 'To be a new' do
  it 'resource be a new' do
    expect(assigns(object.to_sym)).to be_a_new(object_class)
  end
end

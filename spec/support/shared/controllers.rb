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

shared_examples_for 'To render edit view' do
  it 'render show view' do
    expect(response).to render_template :edit
  end
end

shared_examples_for 'To render update view' do
  it 'render update view' do
    patch :update, params: params.merge({id: object.id}), format: :js
    expect(response).to render_template :update
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
  it 'not deletes the object' do
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

shared_examples_for 'To update the object' do
  it 'update the object in the database' do
    patch :update, params: params.merge({id: object.id }), format: :js
    expect(assigns(object.class.to_s.downcase.to_sym)).to eq object
  end
end

shared_examples_for 'To change the object attributes title body' do
  it 'change the object attributes' do
    patch :update, params: params.merge({id: object.id }), format: :js
    object.reload

    expect(object.title).to eq 'new_title' if object.respond_to?(:title)
    expect(object.body).to eq 'new_body'
  end

  it 'render update view' do
    patch :update, params: params.merge({id: object.id }), format: :js
    expect(response).to render_template :update
  end
end

shared_examples_for 'To not change the object attributes title body' do
  before { patch :update, params: params.merge({id: object.id }), format: :js }

  it 'does not change object' do
    object.reload
    expect(object.title).to eq 'MyTitle' if object.respond_to?(:title)
    expect(object.body).to eq 'MyBody'
  end
end

shared_examples_for 'To redirect to path' do
  it 'redirect to path' do
    expect(response).to redirect_to path
  end
end

shared_examples_for 'To does not save a new object' do
  it 'does not save a new object' do
    expect { post :create, params: params, format: :js }.to_not change(object_class, :count)
  end
end

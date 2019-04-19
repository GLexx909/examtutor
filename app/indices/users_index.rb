ThinkingSphinx::Index.define :user, with: :active_record do
  #fields
  indexes first_name, sortable: true
  indexes last_name, sortable: true

  #attributes
  has created_at, updated_at
end

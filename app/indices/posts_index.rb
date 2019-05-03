ThinkingSphinx::Index.define :post, with: :active_record do
  #fields
  indexes title, sortable: true
  indexes author.email, as: :author, sortable: true

  #attributes
  has author_id, created_at, updated_at
end

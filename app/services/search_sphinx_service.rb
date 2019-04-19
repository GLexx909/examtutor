class Services::SearchSphinxService
  CATEGORY = %w(Везде Пользователь Пост) # Coordinate it with view helper: resources_helper.rb

  def find(category_query, search_query, page)
    if access_open(category_query, search_query)
      category(category_query).search(escape(search_query), page: page, per_page: 10)
    end
  end

  private

  def category(category_query)
    if category_query == 'Везде'
      ThinkingSphinx
    elsif category_query == 'Пост'
      Post
    elsif category_query == 'Пользователь'
      User
    end
  end

  def escape(search_query)
    ThinkingSphinx::Query.escape(search_query)
  end

  def access_open(category_query, search_query)
    CATEGORY.include?(category_query) && search_query.present?
  end
end

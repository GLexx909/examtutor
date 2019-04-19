module ApplicationHelper
  def render_flash
    %w(notice alert).select { |type| flash.key?(type) }.map { |type| flash_block(type) }.join.html_safe
  end

  def attendance_colors
    %w(LimeGreen OrangeRed Gold DeepSkyBlue DarkGrey)
  end

  def category_list
    %w(Везде Пользователь Пост) # Coordinate it with Services::SearchSphinxService CATEGORY
  end

  def path_to_resource(resource)
    case resource.class.name
    when 'User'
      profile_path(resource)
    when 'Post'
      post_path(resource)
    else
      false
    end
  end

  def text_of_resource(resource)
    case resource.class.name
    when 'User'
      resource.full_name
    when 'Post'
      resource.title
    else
      false
    end
  end

  private

  def flash_block(type)
    flash_classes = { notice: 'alert alert-success', alert: 'alert alert-danger' }
    content_tag(:div, class: flash_classes[type.to_sym]) do
      content_tag('button', '×', class: 'close clear', "data-dismiss" => "alert") + flash[type.to_sym]
    end
  end
end

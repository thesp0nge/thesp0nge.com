def keywords
  if is_front_page?
    tag_set.join(', ') 
  else
    tags = @item[:tags].nil? ? '' : @item[:tags].join(', ') 
    keywords = @item[:keywords] || ''
    [keywords, tags].join(', ')
  end
end

def link_unless_current(s)
  if @item.identifier != "/#{s}/" 
    "<li><a href='/#{s}.html'>#{s}</a></li>"   
  else
    "<li><a href='/#{s}.html' class='active'>#{s}</a></li>"   
  end
end

def logo
  "<a href='/'><img src='"+gravatar_img+"' class='avatar'/></a>"
end
def pretty_title(item)
  if item[:title]
    "#{item[:title]} - #{site_name}"
  else
    "#{site_name}"
  end
end
def flag_image(lang)
  if (lang.include? 'it')
    "<img src='/images/it.png' />" 
  else
    "<img src='/images/en.png' />" 
  end
end

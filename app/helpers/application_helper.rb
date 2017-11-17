module ApplicationHelper

  def urls_to_images(s)
    s.gsub! /\s(http:\/\/.*?(\.png|jpg))\s/,
    '<p><img src="\1" width=200px/></p>'
    s.html_safe
  end

  def urls_to_links(s)
    s.gsub! /\s(http:\/\/.*?)\s/,
    '<p><a href="\1">\1 </a></p>'
    s.html_safe
  end
end


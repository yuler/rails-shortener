module ApplicationHelper
  def gavatar_image_tag(email, **)
    image_tag(gavatar_url(email), **)
  end

  # refs: https://docs.gravatar.com/gravatar-images/ruby/
  def gavatar_url(email)
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end

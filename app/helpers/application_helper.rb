module ApplicationHelper
  def gavatar_image_tag(email, **kwarg)
    image_tag gavatar_url(email), **kwarg
  end

  # refs: https://docs.gravatar.com/gravatar-images/ruby/
  def gavatar_url(email)
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end

module ApplicationHelper
  def profile_img(user)
    return image_tag(user.avatar, :size => "80x80", alt: user.name) if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name, :size => "80x80")
  end
end
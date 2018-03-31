module DealsHelper
  extend ActiveSupport::Concern
  include LinkTool

  def link_to_add_images(class_name, form, association)
    add_file(class_name, form, association)
  end

  def show_first_image(deal)
    if deal.images.any?
      image_tag deal.images.first.attachment.url(:thumb)
    else
      image_tag 'no_image_found'
    end
  end

end

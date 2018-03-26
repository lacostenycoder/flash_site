module DealsHelper
  extend ActiveSupport::Concern
  include Linker
  def link_to_add_images(name, form, association)
    add_images(name, form, association)
  end
end

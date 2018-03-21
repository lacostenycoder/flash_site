module DealsHelper
  def link_to_add_images(name, form, association)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render 'deal_images', builder: builder
    end

    link_to name, '#', class: 'add_images', data: { id: id, fields: fields.gsub("\n", "") }
  end
end

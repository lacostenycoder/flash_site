module ApplicationHelper

  def error_message_on(object, attribute)
    raw content_tag :span, object.errors.full_messages_for(attribute).to_sentence, class: 'alert-form'
  end

  def link_to_add_images(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render 'deal_images', f: builder
    end

    link_to name, '#', class: 'add_images', data: { id: id, fields: fields.gsub("\n", "") }
  end
end

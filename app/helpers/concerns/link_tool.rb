module LinkTool
  def add_file(class_name, form, association)
    name = class_name.split('_').map(&:capitalize).join(' ')
    partial = class_name.split('_').last
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render partial, builder: builder
    end

    link_to name, '#', class: class_name, data: { id: id, fields: fields.gsub("\n", "") }
  end

end

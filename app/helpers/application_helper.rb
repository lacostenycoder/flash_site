module ApplicationHelper

  def error_message_on(object, attribute)
    raw content_tag :span, object.errors.full_messages_for(attribute).to_sentence, class: 'alert-form'
  end
end

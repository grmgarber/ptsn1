module ApplicationHelper
  def errors_for(model, attribute)
    if model.errors[attribute]
      render partial: 'errors/attribute_error', locals: {message: model.errors[attribute].join(', ')}
    end
  end
end

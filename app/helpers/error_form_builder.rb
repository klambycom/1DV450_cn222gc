class ErrorFormBuilder < ActionView::Helpers::FormBuilder
  def error_for attribute
    if @object.errors[attribute].present?
      @template.content_tag "div",
                            @object.errors[attribute].join(", "),
                            class: "text-danger"
    end
  end
end

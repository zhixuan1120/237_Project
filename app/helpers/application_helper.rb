module ApplicationHelper
  # Returns the full title on a pre-page basis.
  def title(page_title)
    # Calling content_for stores a block of markup, which is page_title, in an identifier, which is :title for later use.
    # yield can be used to retrieve the stored content.
    content_for :title, page_title
    # above code can also be written in format below
    # content_for :title do
    #   page_title
    # end
  end

  def bootstrap_class_for(msg_type)
  	{ success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[msg_type.to_sym]
  end
end

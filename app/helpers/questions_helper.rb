module QuestionsHelper
  def formatted_status(question)

    if question.answers.pending.count == 0
      content_tag :span, "<i class='icon-ok'></i>".html_safe, class: 'label label-success'
    else
      content_tag :span, "pending", class: 'label'
    end

  end
end
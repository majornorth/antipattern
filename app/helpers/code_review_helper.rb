module CodeReviewHelper
  def markdown_to_html content
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true).render(content).html_safe
  end

  def is_owner_of? code_review
    current_user.id == code_review.user.id
  end

  def has_offered? args
    args[:code_review].offers.any? { |offer| offer.user_id == current_user.id }
  end

  def owned_by_current_user args
    args[:offers].select { |offer| offer.user_id == current_user.id }
  end

  def friendly_display date
    date.strftime '%B %d, %Y'
  end
end

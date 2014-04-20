module CommentsHelper
  def markdown comment
    renderer_options = {
      filter_html: true,
      hard_wrap: true
    }
    markdown_options = {
      autolinks: true,
      highlight: true,
      quote: true,
      footnotes: true
    }
    renderer = Redcarpet::Render::HTML.new(renderer_options)
    md ||= Redcarpet::Markdown.new(renderer, markdown_options)
    md.render(comment.content).html_safe
  end
end
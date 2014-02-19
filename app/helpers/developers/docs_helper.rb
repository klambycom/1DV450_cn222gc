module Developers::DocsHelper
  def markdown text
    render_options = {
      filter_html: true
    }
    renderer = Redcarpet::Render::HTML.new render_options

    extensions = {
      autolink: true,

      # ```ruby
      # code
      # ```
      fenced_code_blocks: true,

      # ~~word~~ => striketrough
      striketrough: true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end

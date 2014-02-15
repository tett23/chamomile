module ViewHelper
  def button_link(str, url, options={})
    default_confirm_message = '実行しますか？'
    attributes = {
      href: url
    }
    attributes[:class] = "#{options[:button_class]}"
    attributes[:'data-method'] = "#{options[:method].nil? ? :get : options[:method]}"
    attributes[:disabled] = true if options[:disabled]
    attributes[:'data-confirm'] = options[:confirm_message] || default_confirm_message if options[:confirm]

    options[:glyph] = 'glyph glyphicon-'+options[:glyph].to_s unless options[:glyph].blank?

    haml = <<EOS
%button{type: 'button', class: 'btn#{options[:class]}'}
  %a{attributes}
    %span{class: '#{options[:glyph] if options.key?(:glyph)}'}
    #{str}
EOS

    Haml::Engine.new(haml).render(Object.new, :attributes=>attributes)
  end

  def wiki_format(text)
    return '' if text.blank?

    text = RedCloth.new(text).to_html

    pre_mode = false
    project_id = params[:project_id]
    text.lines.to_a.map do |line|
      pre_mode = true if line =~ /<\s*pre\s*>/
      pre_mode = false if line =~ /<\s*\/\s*pre\s*>/

      unless pre_mode
        line = line.gsub(/\[\[(.+?)\|(.+?)\]\]/) do |_|
          page_name, alt_name = $1, $2

          is_page_exist = Page.find_by_wiki_slug_and_flagment(@current_wiki.slug, page_name)

          "<a href='/wiki/#{@current_wiki.slug}/#{page_name}' class='#{'new' unless is_page_exist}'>#{alt_name || page_name}</a>"
        end
        line = line.gsub(/\[\[(.+?)\]\]/) do |title|
          title.gsub!(/[\[\]]/, '')

          is_page_exist = Page.find_by_wiki_slug_and_flagment(@current_wiki.slug, title)

          "<a href='/wiki/#{@current_wiki.slug}/#{title}' class='#{'new' unless is_page_exist}'>#{title}</a>"
        end
      end

      line
    end.join()
  end
end

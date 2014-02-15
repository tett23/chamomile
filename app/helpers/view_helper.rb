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

  def textile(text)
    RedCloth.new(text).to_html
  end
end

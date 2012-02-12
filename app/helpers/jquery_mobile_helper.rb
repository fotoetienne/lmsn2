# Based on rails-jquery-mobile gem <https://github.com/wakeless/rails-jquery-mobile>
module JqueryMobileHelper
  ATTRIBUTES = [:theme, :collapsed, :transition, :direction, :ajax, :role, :icon, :position, :inset, :filter]
  [:page, :navbar, :content, :footer, :header, :collapsible].each do |name|
    class_eval "def jqm_#{name} (options = {}, &content)
      mobile_div('#{name}', options) do
        yield content
      end
    end"
  end

  def jqm_listview(options = {})
    mobile_tag :ul, {:role => :listview, :inset => :true},options do
      yield if block_given?
    end
  end

  def li_link_to(text,path,options={})
    content_tag :li, link_to(text,path,jqm_parse_options(options))
  end

  def jqm_numberedlist(options)
    mobile_tag :ol, {:role => "listview", :theme => "g"}, options do
      yield if block_given?
    end
  end

  def jqm_bar(options = {})
    default_class = 'ui-bar '
    if options.include?(:class)
      default_class << options[:class].to_s
      options.delete(:class)
    end
    if options.include?(:theme)
      default_class << 'ui-bar-'+options[:theme].to_s
      options.delete(:theme)
    end
    mobile_tag :div, {:class => default_class}, options do
      yield if block_given?
    end
  end

  def jqm_field(options = {})
    mobile_tag :div, {:role => 'fieldcontain'}, options do
      yield if block_given?
    end
  end

  protected

    def mobile_tag(tagname, default = {}, options = {})
      jqm_content_tag tagname, default.merge(options) do
        yield if block_given?
      end
    end

    def mobile_div(role, options = {}, &block)
      jqm_content_tag(:div, options.merge(:role => role)) do
        yield if block_given?
      end
    end

    def jqm_content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
      if block_given?
        options = jqm_parse_options content_or_options_with_block
        content_tag name, options, options, escape do
          yield
        end
      else
        options = jqm_parse_options options
        content_tag name, content_or_options_with_block, options, escape
      end
    end

    def jqm_parse_options(options=nil)
      unless options.nil?
        newoptions = {}
        options.each do |key, value|
          if ATTRIBUTES.include?(key.to_sym)
            options.delete(key)
            newoptions["data-#{key}"] = value
          end
        end
        options.update(newoptions)
      end
      return options
    end
  #ActionView::Base.send :include, JqueryMobileHelper
end

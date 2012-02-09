=begin
require "action_view"

module ActionView
  module Helpers
    module TagHelper
      ATTRIBUTES = [:theme, :collapsed, :transition, :direction, :ajax, :role, :icon, :position, :inset]

      def content_tag_with_mobile(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
        if block_given?
          options = mobile_parse_options content_or_options_with_block
          content_tag_without_mobile name, options, options, escape do
            yield
        end
        else
          options = mobile_parse_options options
          content_tag_without_mobile name, content_or_options_with_block, options, escape
        end
      end


      alias_method_chain :content_tag, :mobile

      def mobile_parse_options(options=nil)
        unless options.nil?
          options.each do |key, value|
            if ATTRIBUTES.include?(key.to_sym)
              options.delete(key)
              options["data-#{key}"] = value
            end
          end
        end
        return options
      end
    end
  end
end
=end

# Based on https://github.com/wakeless/rails-jquery-mobile
module JqueryMobileHelper
  ATTRIBUTES = [:theme, :collapsed, :transition, :direction, :ajax, :role, :icon, :position, :inset]
  [:jqm_page, :jqm_navbar, :jqm_content, :jqm_footer, :jqm_header, :jqm_collapsible].each do |name|
    class_eval "def #{name} (options = {}, &content)
      mobile_div('#{name}', options) do
        yield content
      end
    end"
  end

  def jqm_listview(options = {})
    mobile_tag :ul, {:role => "listview", :theme => "g"},options do
      yield if block_given?
    end
  end

  def jqm_numberedlist(options)
    mobile_tag :ol, {:role => "listview", :theme => "g"}, options do
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

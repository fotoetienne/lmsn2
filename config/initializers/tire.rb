# Initializers for Tire 
# Be sure to restart your server when you modify this file.

# Add a prefix to all indexes to separate dev index from production
Tire::Model::Search.index_prefix Rails.env

# Add routing to search
Tire::Search::Search.class_eval do
  #Original method:
  # def url
  #   Configuration.url + @path
  # end
  def url_with_routing
    if @options[:routing]
      @path << '?routing=' + @options.delete(:routing).to_s
    end
    url_without_routing
  end

  alias_method_chain :url, :routing
end

# Write to a log if in dev mode
if Rails.env.development?
  Tire.configure { logger 'log/elasticsearch.log', :level => 'debug' }
end

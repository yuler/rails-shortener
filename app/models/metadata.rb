require "net/http"

class Metadata
  attr_reader :doc

  def initialize(html = nil)
    @doc = Nokogiri::HTML(html)
  end

  def attributes
    {
      title:,
      description:,
      image:,
    }
  end

  def title
    doc.at_css("title")&.text
  end

  def description
    meta_tag_content "description"
  end

  def image
    meta_tag_content "og:image", name_attribute: :property
  end

  def meta_tag_content(name, name_attribute: :name)
    doc.at_css("meta[#{name_attribute}='#{name}']")&.attributes&.fetch("content", nil)&.text
  end

  def self.retrieve_from(url)
    new(fetch_html(url))
  end

  def self.fetch_html(uri_str, scheme = URI(uri_str).scheme, limit = 10)
    raise ArgumentError, "too many HTTP redirects" if limit == 0

    response = Net::HTTP.get_response(URI(uri_str))

    case response
    when Net::HTTPSuccess
      response.body
    when Net::HTTPRedirection
      location = response["location"]
      location = "#{scheme}:#{location}" if URI(location).scheme.nil?
      warn "Redirected to #{location}"
      fetch_html(location, scheme, limit - 1)
    else
      response.value
    end
  end
end

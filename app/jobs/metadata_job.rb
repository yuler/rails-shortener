class MetadataJob < ApplicationJob
  queue_as :default

  def perform(link)
    link.update Metadata.retrieve_from(link.url).attributes
  end
end

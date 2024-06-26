class MetadatasController < ApplicationController
  def index
    @metadatas = Metadata.parse_xml
  end
end

class MetadatasController < ApplicationController
  def index
    @metadatas = Metadata.parse_xml

    @metadatas.sort!{ |m1, m2|
      if m1[:publication_date].blank?
        1
      elsif m2[:publication_date].blank?
        -1
      else
        Date.parse(m2[:publication_date]) <=> Date.parse(m1[:publication_date])
      end
    }
  end
end

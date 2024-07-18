class MetadatasController < ApplicationController
  def index
    @metadatas = Metadata.parse_xml

    @metadatas.sort!{|m1, m2| sort_logic(params[:sort_order], m1[params[:sort_column]&.to_sym], m2[params[:sort_column]&.to_sym])}
  end
  
  private
  
  def sort_logic(ord, m1, m2)
    if m1.blank?
      1
    elsif m2.blank?
      -1
    else
      if ord.to_sym == :desc
        Date.parse(m2) <=> Date.parse(m1)
      elsif ord.to_sym == :asc
        Date.parse(m1) <=> Date.parse(m2)
      end
    end
  end
end

class Metadata
  include ActiveModel::Model

  def self.parse_xml
    xml_data = File.read(Rails.root.join("tmp/metadata_cached_file.xml"))
    xml = Nokogiri::XML(xml_data)
    item_nodes = xml.xpath('//meta_data')

    items = item_nodes.map do |item|
      full_title = item.at_xpath('./title').text
      next if "---------------" == full_title # 書籍を参照不可能なメタデータは除外する
      label = full_title.match(/\(([^)]{2,})\)$/) # タイトルにレーベル名と思しき部分があるなら抽出
      asin = item.at_xpath('./ASIN').text

      {
        desktop_url: "kindle://book/?action=open&asin=#{asin}", # デスクトップアプリで書籍を開カスタムURLスキーム
        web_url: "https://read.amazon.co.jp/manga/#{asin}", # ブラウザ版ビューワーで書籍を開くURL
        asin: asin,
        title: label ? full_title.gsub(label[0], '').rstrip : full_title,
        author: item.at_xpath('./authors/author[1]')&.text,
        label: label ? label[1] : "_",
        publisher: item.at_xpath('./publishers/publisher[1]')&.text,
        publication_date: item.at_xpath('./publication_date').text,
        purchase_date: item.at_xpath('./purchase_date').text,
        origin: item.at_xpath('./origins/origin[1]').text,
      }
    end.compact
  end
end

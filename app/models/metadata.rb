class Metadata
  include ActiveModel::Model

  def self.parse_xml
    xml_data = File.read(Rails.root.join("tmp/metadata_cached_file.xml"))
    xml = Nokogiri::XML(xml_data)
    metadatas = xml.xpath('//meta_data')

    metadatas.map do |m|
      full_title = m.at_xpath('./title').text
      next if "---------------" == full_title # 書籍を参照不可能なメタデータは除外する
      label = full_title.match(/\(([^)]{2,})\)$/) # タイトルにレーベル名と思しき部分があるなら抽出
      asin = m.at_xpath('./ASIN').text
      author = m.at_xpath('./authors/author[1]') # 共著の場合は一人目を著者とする
      publisher = m.at_xpath('./publishers/publisher[1]') # 共同出版の場合は１社目を出版社とする

      {
        desktop_url: "kindle://book/?action=open&asin=#{asin}",           # アプリで書籍を開くカスタムURLスキーム
        web_url: "https://read.amazon.co.jp/manga/#{asin}",               # ブラウザ版ビューワーで書籍を開くURL
        asin: asin,                                                       # 書籍識別番号
        title: label ? full_title.gsub(label[0], '').rstrip : full_title, # レーベル部分を除いたタイトル
        author: author&.text,                                             # 著者名
        author_pronunciation: author&.attr('pronunciation'),         # 著者名読み
        label: label ? label[1] : "_",                                    # レーベル名
        publisher: publisher&.text,                                       # 出版社名
        publisher_pronunciation: publisher&.attr('pronunciation'),   # 出版社名読み
        publication_date: m.at_xpath('./publication_date').text,          # 出版日
        purchase_date: m.at_xpath('./purchase_date').text,                # 購入日
        origin: m.at_xpath('./origins/origin[1]').text,                   # 取得元
      }
    end.compact
  end
end

require 'fileutils'
require 'yaml'

# KindleforPCが管理している購入済みKindle書籍の目録を取得しキャッシュを作成
resources = YAML.load_file(Rails.root.join("config/resources.yml"))
cache_path = Rails.root.join("tmp/metadata_cached_file.xml")

# メタデータxmlが見つからなければサンプルファイルを使用
if File.exist?(resources["metadata_xml_path"])
  FileUtils.cp(resources["metadata_xml_path"], cache_path)
else
  FileUtils.cp(Rails.root.join("lib/ExampleMetadata.xml"), cache_path)
end

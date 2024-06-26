require 'fileutils'
require 'yaml'

cache_path = Rails.root.join("tmp/metadata_cached_file.xml")
resources_path = Rails.root.join("config/resources.yml")
resources = YAML.load_file(resources_path) if File.exist?(resources_path)

if resources && File.exist?(resources["metadata_xml_path"])
  # KindleforPCが管理している購入済みKindle書籍のを取得しキャッシュを作成
  FileUtils.cp(resources["metadata_xml_path"], cache_path)
elsif File.exist?(cache_path)
  # メタデータがなければ前回のキャッシュを使用
else
  # メタデータxmlもキャッシュもなければサンプルファイルを使用
  FileUtils.cp(Rails.root.join("lib/ExampleMetadata.xml"), cache_path)
end

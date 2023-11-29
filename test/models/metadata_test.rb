require "test_helper"

class MetadataTest < ActiveSupport::TestCase
  test "retrieve baidu" do
    metadata = Metadata.retrieve_from("https://baidu.com")
    assert_equal "百度一下，你就知道", metadata.title
    assert_match(/^全球领先的中文搜索引擎/, metadata.description)
    assert_nil metadata.image
  end

  test "retrieve zhihu" do
    metadata = Metadata.retrieve_from("https://zhihu.com")
    assert_equal "知乎 - 有问题，就会有答案", metadata.title
    assert_match(/^知乎，中文互联网高质量的问答社区/, metadata.description)
    assert_equal nil, metadata.image
  end
end

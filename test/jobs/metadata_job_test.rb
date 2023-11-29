require "test_helper"

class MetadataJobTest < ActiveJob::TestCase
  test "fetch baidu metadata" do
    link = links(:baidu)
    MetadataJob.perform_now(link)
    p link
    assert_equal "百度一下，你就知道", link.title
    assert_match(/^全球领先的中文搜索引擎/, link.description)
    assert_equal nil, link.image
  end

  # test "fetch zhihu metadata" do
  #   link = links(:zhihu)
  #   MetadataJob.perform_now(link)
  #   p link
  # end
end

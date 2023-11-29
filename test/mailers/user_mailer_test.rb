require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "magic_link" do
    user = users(:one)
    mail = UserMailer.with(user:).magic_link

    assert_equal "Magic sign in link!", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@localhost.com"], mail.from
    assert_match "sign in", mail.body.encoded
  end
end

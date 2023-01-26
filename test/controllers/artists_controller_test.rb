require "test_helper"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get summary" do
    get artists_summary_url
    assert_response :success
  end
end

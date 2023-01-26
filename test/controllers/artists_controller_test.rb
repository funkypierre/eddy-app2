require "test_helper"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get recap" do
    get artists_recap_url
    assert_response :success
  end
end

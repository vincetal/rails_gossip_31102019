require 'test_helper'

class TeamControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get team_index_url
    assert_response :success
  end

  test "should get contact" do
    get team_contact_url
    assert_response :success
  end

end

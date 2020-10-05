require 'test_helper'

class HousingReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get housing_reservations_index_url
    assert_response :success
  end

  test "should get show" do
    get housing_reservations_show_url
    assert_response :success
  end

  test "should get create" do
    get housing_reservations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get housing_reservations_destroy_url
    assert_response :success
  end

end

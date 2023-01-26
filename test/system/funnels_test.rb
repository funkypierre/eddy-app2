require "application_system_test_case"

class FunnelsTest < ApplicationSystemTestCase
  test 'it should access the homepage' do
    visit root_path

    assert_text 'Artists recap'
    assert_text 'Metallica'
  end

  test 'it should access an artist catalog through the recap' do
    visit root_path

    click_on 'Metallica'
    assert_text 'RIDE THE LIGHTNING (1984)'
    assert_no_text 'Turnstile'
  end

  test 'it should be able to filter one artist on the catalog' do
    visit artists_catalog_url

    fill_in 'search', with: "Turnstile\n"
    assert_no_text 'Metallica'
    assert_text 'Turnstile'
  end
end

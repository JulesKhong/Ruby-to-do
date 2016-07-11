require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('homepage path',{ :type => :feature}) do
  it("shows the user the homepage when the site loads") do
    visit('/')
    expect(page).to have_content('all your task')
  end

  it('displays the list name on the list add result page') do
    visit('/')
    fill_in('name', :with => 'Groceries')
    click_button('Add list')
    expect(page).to have_content('Groceries')
  end
end

describe('adding list details',{ :type => :feature}) do
  it("allows user to add items to a list") do
    visit('/')
    fill_in('name', :with => 'Groceries')
    click_button('Add list')
    fill_in('item_1', :with => 'milk')
    fill_in('item_2', :with => 'broccoli')
    click_button('Add items')
    expect(page).to have_content('broccoli')
  end
end

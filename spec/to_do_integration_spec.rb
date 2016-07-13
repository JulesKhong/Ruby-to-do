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
    fill_in('due_1', :with => '2016-01-01')
    # fill_in('item_2', :with => 'broccoli')
    click_button('Add items')
    expect(page).to have_content('milk')
  end

  it("displays list form when user clicks 'Add more items' link") do
    visit('/')
    fill_in('name', :with => 'Groceries')
    click_button('Add list')
    fill_in('item_1', :with => 'milk')
    fill_in('due_1', :with => '2016-07-25')
    # fill_in('item_2', :with => 'broccoli')
    click_button('Add items')
    click_link('See all lists')
    expect(page).to have_content('Create a new list')
  end

  it("allows users to enter a due date for each item") do
    visit('/')
    fill_in('name', :with => 'Groceries')
    click_button('Add list')
    fill_in('item_1', :with => 'milk')
    fill_in('due_1', :with => '2016-07-25')
    # fill_in('item_2', :with => 'broccoli')
    # fill_in('due_2', :with => '2016-08-21')
    click_button('Add items')
    expect(page).to have_content('2016-07-25')
  end

  describe('adding tasks to a list', {:type => :feature}) do
    it('allows users to add a task to a list') do
      test_list = List.new({:name => "School Stuff"})
      test_list.save()

      # visit('/')
      # fill_in('name', :with => 'Groceries')
      # click_button('Add list')
      # fill_in('item_1', :with => 'milk')
      # fill_in('due_1', :with => '2016-07-25')
      # click_button('Add items')
      #
      #
      #
      visit("/lists/#{test_list.id()}")
      select("School Stuff", :from => 'list_id')
      fill_in("description", {:with => "Learn SQL"})
      fill_in("due_1", {:with => '2016-07-25'})
      click_button('Add task')
      expect(page).to have_content("updated")
    end
  end
end

require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }

  let(:post) do
    FactoryGirl.create(:post, :user => user)
  end

  before do
    login_as(user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

  	it 'can be reached successfully' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'has a title of Posts' do
  		expect(page).to have_content(/Posts/)
  	end

    it 'has a list of posts' do
      post1 = FactoryGirl.build_stubbed(:post, :user => user)
      post2 = FactoryGirl.build_stubbed(:second_post, :user => user)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
    end

    it 'has a scope so that only post creators can see their posts' do
      other_user = FactoryGirl.create(:other_user)
      post_from_other_user = FactoryGirl.create(:post_from_other_user, :user => other_user)

      visit posts_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
    end
  end

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryGirl.create(:user)
      login_as(delete_user, :scope => :user)
      post_to_delete = FactoryGirl.create(:post, :user => delete_user)

      visit posts_path

      click_link("delete_#{post_to_delete.id}")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
  	before do
  		visit new_post_path
  	end

  	it 'has a new form that can be reached' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      fill_in 'post[overtime_request]', with: 4.5

      expect { click_on "Save" }.to change(Post, :count).by(1)
  	end

    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      fill_in 'post[overtime_request]', with: 4.5
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User Association")
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited content"
      click_on "Save"      

      expect(page).to have_content("Edited content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      other_user = FactoryGirl.create(:other_user)
      login_as(other_user, :scope => :user)      

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end
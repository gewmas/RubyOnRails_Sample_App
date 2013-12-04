require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_content('Sign in') }
		it { should have_title('Sign in') }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_title('Sign in') }
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }
		end

		describe "after visiting another page" do
			before { click_link "Home" }
			it { should_not have_selector('div.alert.alert-error') }
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			# before do
			# 	fill_in "Email",    with: user.email.upcase
			# 	fill_in "Password", with: user.password
			# 	click_button "Sign in"
			# end
			# Change to the spec/support/utilities.rb
			before { sign_in user }

			it { should have_title(user.name) }
			it { should have_link('Profile',     href: user_path(user)) }
			it { should have_link('Settings',    href: edit_user_path(user)) }
			it { should have_link('Sign out',    href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }

			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('Sign in') }
				end

				# apart from Capybara’s visit method, to access a controller action: by issuing the appropriate HTTP request directly, 
				# in this case using the patch method to issue a PATCH request:
				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end
			end

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email",    with: user.email
					fill_in "Password", with: user.password
					click_button "Sign in"
				end

				describe "after signing in" do
					# Should redirect back to Edit page after re-signin
					it "should render the desired protected page" do
						expect(page).to have_title('Edit user')
					end
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			# This creates a user with a different email address from the default. The tests specify that the original user should not 
			# have access to the wrong user’s edit or update actions.
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the Users#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('Edit user')) }
				specify { expect(response).to redirect_to(root_url) }
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end
		end
	end
end
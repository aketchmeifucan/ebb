include ApplicationHelper

def match_alert(subject, level, message)
  subject.should have_selector("div.alert.alert-#{level}", text: message)
end

RSpec::Matchers.define :have_success do |expected|
  match do |actual|
    match_alert(actual, 'success', expected)
  end
end

RSpec::Matchers.define :have_notice do |expected|
  match do |actual|
    match_alert(actual, 'notice', expected)
  end
end

RSpec::Matchers.define :have_error do |expected|
  match do |actual|
    match_alert(actual, 'error', expected)
  end
end

def signin(user)
  visit signin_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def full_title(page_title)
	base_title = "Ruby on Rails Tutorial Sample App"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end


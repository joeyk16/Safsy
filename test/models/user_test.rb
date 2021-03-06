require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user =  User.new(username: "Exampleuser", email: "user@example.com",
							password: "foobar16", password_confirmation: "foobar16")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "username should be present" do 
		@user.username = "  "
		assert_not @user.valid?
	end

	test "email should be present" do 
		@user.email = "  "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.username = "a" * 51
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email validation should reject invalid addresses" do 
		invalid_addresses = %w[user.exmaple,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password is a minimum of 6 digests or letters" do
  	@user.password = @user.password_confirmation = "a" * 5 
  	assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # test_all_shows
  test "all_shows_behaves_correctly" do
    user = build(:user, approved: true)
    user.skip_confirmation!
    user.save

    show = create(:show)
    ShowMembership.create(show:show, user:user)
    team = create(:team, hub_show:show)
    TeamMembership.create(team:team, user:user)

    assert_equal 2, user.all_shows.count
  end

end

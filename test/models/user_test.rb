require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # test_all_shows
  test "all_shows_returns_all_shows" do
    user = build(:user, approved: true)
    user.skip_confirmation!
    user.save

    show1 = create(:show)
    ShowMembership.create(show:show1, user:user)

    show2 = create(:show, title: 'Show 2')
    team = create(:team, hub_show:show2)
    TeamMembership.create(team:team, user:user)

    assert_equal 2, user.all_shows.count
  end


  test "all_shows_filters_duplicates" do
    user = build(:user, approved: true)
    user.skip_confirmation!
    user.save

    show = create(:show)
    ShowMembership.create(show:show, user:user)
    team = create(:team, hub_show:show)
    TeamMembership.create(team:team, user:user)

    assert_equal 1, user.all_shows.count
  end

end

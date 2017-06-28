class ShowMembership < ApplicationRecord

  belongs_to :user
  belongs_to :show

  validates_presence_of :user, :show
  validates_uniqueness_of :user_id, :scope => :show_id

end

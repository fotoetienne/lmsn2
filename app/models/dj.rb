class Dj < ActiveRecord::Base
  validates_presence_of :name
end
# == Schema Information
#
# Table name: djs
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  user_id       :integer
#  public        :boolean         default(FALSE)
#  payed_through :date
#  free          :boolean         default(FALSE)
#  promocode     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#


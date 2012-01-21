class Singer < ActiveRecord::Base
  belongs_to :user
  has_many :song_requests
end
# == Schema Information
#
# Table name: singers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

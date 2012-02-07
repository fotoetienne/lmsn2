class Song < ActiveRecord::Base
  belongs_to :dj
  has_many :song_requests, :dependent => :destroy
  validates_uniqueness_of :identifier, :scope => :dj_id
end
# == Schema Information
#
# Table name: songs
#
#  id         :integer         not null, primary key
#  dj_id      :integer
#  artist     :string(255)
#  title      :string(255)
#  disc       :string(255)
#  identifier :string(255)
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#


class SongRequest < ActiveRecord::Base
  belongs_to :dj
  belongs_to :song
  belongs_to :singer

  validates :dj_id    ,   :presence => true
  validates :song_id  ,   :presence => true
  validates :name, :presence => {:unless => "singer_id", :message => "The dj needs to know what name to call!"}

  def singer_name
    name || singer.name
  end
end

# == Schema Information
#
# Table name: song_requests
#
#  id          :integer         not null, primary key
#  dj_id       :integer
#  song_id     :integer
#  singer_id   :integer
#  singer_name :string(255)
#  key         :string(255)
#  comments    :string(255)
#  archived    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#


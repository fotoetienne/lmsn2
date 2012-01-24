class Dj < ActiveRecord::Base
#  validates_presence_of :name

  belongs_to :user
  has_many :songs
  has_many :song_requests

  def load_songlist(fn)
    songlist = parse_csv(fn)
    self.songs.create(songlist)
  end 

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


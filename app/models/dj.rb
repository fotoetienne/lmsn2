class Dj < ActiveRecord::Base
#  validates_presence_of :name

  belongs_to :user, :dependent => :destroy
  has_many :songs, :dependent => :destroy
  has_many :song_requests, :dependent => :destroy
  mount_uploader :songlist, SonglistUploader

  def load_songlist(fn, type=:csv)
    if type == :csv
      songlist = parse_csv(fn)
    elsif type == :xls
      songlist = parse_xls(fn)
    end
    self.songs.create(songlist)
  end 

  def load_random_songlist(length=1000)
    songlist = parse_csv(random_songlist(length))
    self.songs.create(songlist)
  end 

  def artists
    self.songs.select("songs.artist,count(*) as count").group(:artist)
#   self.songs.count(:group => :artist)
#   self.songs.select("distinct(songs.artist)")
#   self.songs.find_all(:select => 'distinct artist', :order => 'artist')
  end

# scope :artists, lambda {
#   joins(:songs).
#   select(:artist).uniq
# }

  def songs_by_artist(artist)
    self.songs.where(:artist => artist).order(:title)
  end

  def parse_csv(csvfile)
    songs = []
    CSV.foreach(csvfile,{:headers => true, :skip_blanks => true, :header_converters => :symbol}) do |row|
      this_song = {
      :artist => row[:artist] || "Unknown Artist",
      :title => row[:title] || row[:song],
      :identifier => row[:identifier] || row[:id] || row[:song_id] || nil,
      :disc => row[:disc] || row[:disk] || nil,
      :notes => row[:notes] || row[:note] || nil}
      songs << this_song unless this_song[:title].nil?
    end
    return songs
  end

  def random_songlist(length=100)
    infile='public/songlist.csv'
    outfile='tmp/random_songlist.csv'
    tlength = `cat #{infile} | wc -l`.to_i
    File.open(outfile,'w') do |outlist|
    File.open(infile, 'r') do |inlist|
      outlist.write(inlist.first)
      inlist = inlist.readlines
      length.times do
        outlist.write(inlist[rand(tlength)])
      end
    end
    end
    return outfile
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


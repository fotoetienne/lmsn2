class Dj < ActiveRecord::Base
#  validates_presence_of :name

  belongs_to :user, :dependent => :destroy
  has_many :songs, :dependent => :destroy
  has_many :song_requests, :dependent => :destroy
  mount_uploader :songlist, SonglistUploader

  def slow_load_songlist(fn, type=:csv)
    if type == :csv
      songlist = parse_csv(fn)
    elsif type == :xls
      songlist = parse_xls(fn)
    end
    self.songs.create(songlist)
  end 

  def load_random_songlist(length=1000)
    load_songlist(random_songlist(length))
  end 

  def load_songlist(fn,type=:csv)
    if type == :csv
      songlist = parse_csv(fn)
    elsif type == :xls
      songlist = parse_xls(fn)
    end
    conn = ActiveRecord::Base.connection
    create_time = Time.now
    time = conn.quote(Time.now.to_s(:db))
    inserts = []
    i = 0
    songlist.each do |song|
      artist = conn.quote(song[:artist])
      title = conn.quote(song[:title])
      identifier = conn.quote(song[:identifier])
      inserts.push "(#{[self.id,artist,title,identifier,time,time].join(',')})"
      i += 1
      if i == 1000
        conn.execute "INSERT INTO songs (dj_id,artist,title,identifier,created_at,updated_at) VALUES #{inserts.join(',')}"
        inserts = []
        i = 0
      end
    end
    unless inserts.empty?
      conn.execute "INSERT INTO songs (dj_id,artist,title,identifier,created_at,updated_at) VALUES #{inserts.join(',')}"
    end
    #new_songs = self.songs.all(:conditions => {:created_at => time},:select => [:dj_id,:id,:artist,:title])
    #Song.index.import new_songs
    self.songs.find_in_batches(:conditions => "created_at = "+time,:select => [:dj_id,:id,:artist,:title]) do |song_batch|
      Song.index.import song_batch
    end

    if self.songs.count != self.search_songs.total
      rebuild_search_index
    end
  
    return true
  end 

  def destroy_all_songs
    self.songs.delete_all
    self.song_requests.delete_all
    self.clear_search_index
  end

  def rebuild_search_index
    clear_search_index
    build_search_index
  end

  def build_search_index
    # Adds all songs for this dj into the elasticsearch index
    self.songs.find_in_batches(:select => [:dj_id,:id,:artist,:title]) do |song_batch|
      Song.index.import song_batch
    end
  end

  def clear_search_index
    # Clears all songs for the current dj from the elasticsearch index
  
    #query_string = "_query?routing=#{id}?q=dj_id:#{id}"
    #query_url = [Tire::Configuration.url,Song.index_name,query_string].join('/')
    #result = RestClient::Request.new(:method => :delete, :url => query_url).execute
    query_string = "_query?routing=#{id}"
    query_url = [Tire::Configuration.url,Song.index_name,query_string].join('/')
    payload = { term: {dj_id: id} }.to_json
    result = RestClient::Request.new(:method => :delete, :url => query_url, :payload => payload).execute
    #Song.search(:routing => self.id, :delete => true) { query { string '*' }; filter :terms,:dj_id => [self.id] }
    #Tire.search(Song.index_name, :routing => dj.id, :delete => true) { query { string '*' }; filter :terms,:dj_id => [dj.id] }
  end

  def search_songs(search_string='*',page=1)
    @songs = Song.search :page => page, :per_page => 100, :routing => id do |search|
      search.query do |query|
        query.string search_string
      end 
      search.filter :terms, :dj_id => [id]
    end
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


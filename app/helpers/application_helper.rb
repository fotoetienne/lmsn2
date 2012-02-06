require 'csv'

module ApplicationHelper
  def alertbox(name)
    if mobile?
      "ui-bar ui-bar-e" 
    else
      if name == :alert or name == :error
        "alert-box error" #red
      elsif name == :notice
        "alert-box success" #green
      elsif name == :yellow
        "alert-box warning" #yellow
      else
        "alert-box" #grey
      end
    end
  end

  def logo
    image_tag("logo.jpg", :alt => "Let Me Sing Now, llc", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Let Me Sing Now"
    if @title.nil?
      base_title+', llc'
    else
      "#{base_title} | #{@title}"
    end
  end

  def load_songlist(dj,fn)
    songlist = parse_csv(fn)
    dj.songs.create(songlist)
  end

  def random_songlist(infile='public/songlist.csv',outfile='public/songlist10.csv',length=10)
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

  def csv_headers(csvfile)
    h=[]
    CSV.foreach(csvfile,{:headers => true, :skip_blanks => true}) do |row|
      puts row
      if h.empty?
        row.each_index do |i|
          if h[:artist].nil? && row[i].index(/artist/i)
            h[:artist] = i
          elsif h[:title].nil? && row[i].index(/(title)|(song[:]$)/i)
            h[:song] = i
          elsif h[:identifier].nil? && row[i].index(/(id)|(#)/i)
            h[:identifier] = i
          end
        end
      else
        break
      end
    end
    return h
  end

  def parse_csv(csvfile)
    songs = []
    CSV.foreach(csvfile,{:headers => true, :skip_blanks => true, :header_converters => :symbol}) do |row|
      puts row
      this_song = {
      :artist => row[:artist] || "Unknown Artist",
      :title => row[:title] || row[:song],
      :identifier => row[:identifier] || row[:id] || row[:song_id] || nil}
      puts this_song
      songs << this_song unless this_song[:title].nil? 
    end
    return songs
  end

  def load_demo_csv
    CSV.open('public/sample.csv', 'r').each do |row|
      this_song = {
        :artist => row[0],
        :title => row[1],
        :song_id => row[2]}
      if this_song[:artist].nil?
         this_song[:artist] = "Unknown Artist"
      end
      if !this_song[:title].nil? && !this_song[:song_id].nil?
        puts this_song[:artist]+' - '+this_song[:title]
        Song.create(:artist => this_song[:artist],
                    :title => this_song[:title],
                    :dj_id => 1)
      end
    end
  end
end


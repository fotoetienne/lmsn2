require 'csv'

module ApplicationHelper
  def alertbox(name)
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

  def logo
    image_tag("logo.jpg", :alt => "Let Me Sing Now, llc", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Let Me Sing Now, llc"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def parse_csv
    csv_text = File.read('public/sample.csv')
    #csv = CSV.parse(csv_text, :headers => true)

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
                    :dj_id => 3)
      end
    end
  end
end



end

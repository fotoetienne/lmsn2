class Song < ActiveRecord::Base
  belongs_to :dj
  has_many :song_requests#, :dependent => :destroy
# validates_uniqueness_of :identifier, :scope => :dj_id

  include Tire::Model::Search
  include Tire::Model::Callbacks

  tire.mapping :_routing => { :required => :true, :path => :dj_id } do
    indexes :id,           :index    => :not_analyzed
    indexes :dj_id,        :index    => :not_analyzed
    indexes :artist,       :analyzer => 'snowball', :boost => 100
    indexes :title,        :analyzer => 'snowball'
  end

  def to_indexed_json
    to_json :only => [:id, :dj_id, :artist, :title]
  end

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


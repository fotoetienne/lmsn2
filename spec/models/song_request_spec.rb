require 'spec_helper'

describe SongRequest do
  pending "add some examples to (or delete) #{__FILE__}"
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


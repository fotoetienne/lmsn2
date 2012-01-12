require 'spec_helper'

describe Dj do
  pending "add some examples to (or delete) #{__FILE__}"
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


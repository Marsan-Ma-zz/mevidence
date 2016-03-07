# coding: utf-8
class Track
  include Mongoid::BaseModel

  paginates_per 50

  field :title
  field :desc
  field :count, type: Integer, :default => 0

  index title: 1
  index count: 1

  def self.add(action, key)
    track = Track.where(:title => action, :desc => key).first
    track = Track.new(:title => action, :desc => key) if not track
    track.count += 1
    track.save
  end

end

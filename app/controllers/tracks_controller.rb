class TracksController < ApplicationController

  def index
    @tracks = {}
    @tracks['search']   = Track.where(:title => 'search').page(params[:page])
    @tracks['doctor']   = Track.where(:title => 'view_doctor').page(params[:page])
    @tracks['hospital'] = Track.where(:title => 'view_hospital').page(params[:page])
  end

end

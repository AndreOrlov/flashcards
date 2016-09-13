class Dashboard::FlickrController < ApplicationController
  require 'flickraw'
  before_action :set_flickr, only: [:photos]

  def photos
    params = flickr_params
    # p params[:search_tag]

    photos = flickr.photos.search tags: params[:search_tag], per_page: 10
    pics = []
    photos.each do |photo|
      info = flickr.photos.getInfo(photo_id: photo.id)
      embed_photo={}
      embed_photo['flickr']=FlickRaw.url(info) rescue FlickRaw.url_o(info) rescue FlickRaw.url_b(info)
      title = info.title
      square_url = FlickRaw.url_s(info)
      large_square_url = FlickRaw.url_q(info)
      taken = info.dates.taken
      views = info.views
      tags = info.tags.map {|t| t.raw}
      pics.push url: square_url, title: title
    end


    respond_to do |format|
      # TODO
      if params[:search_tag].nil?
        # format.json {render json: {Error: 'Error parameters query'}}
        format.json { head :bad_request}
      else
        format.json {render json: {count: pics.size, photos: pics}}
      end
    end
  end

  private

  def flickr_params
    params.require(:flickr).permit(:search_tag)
  end

  def set_flickr
    FlickRaw.api_key = FLICKR_CONFIG['api_key']
    FlickRaw.shared_secret = FLICKR_CONFIG['shared_secret']

    flickr.access_token = FLICKR_CONFIG['access_token']
    flickr.access_secret = FLICKR_CONFIG['access_secret']
  end

end

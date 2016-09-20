# Flickr class get photo from flickr.com

class Flickr
  require 'flickraw'

  def initialize
    set_flickr
  end

  def flickr_pics(tags, qty_per_page = 10)
    raise ArgumentError, 'Tags isn\'t blank' if tags.blank?

    photos = flickr.photos.search tags: tags, per_page: qty_per_page
    pics = []
    photos.each do |photo|
      info = flickr.photos.getInfo(photo_id: photo.id)
      # embed_photo = {}
      # embed_photo['flickr'] = FlickRaw.url(info) rescue FlickRaw.url_o(info) rescue FlickRaw.url_b(info)
      # large_square_url = FlickRaw.url_q(info)
      # taken = info.dates.taken
      # views = info.views
      # tags = info.tags.map {|t| t.raw}
      square_url = FlickRaw.url_s(info)
      pics.push url: square_url, title: info.title
    end
    pics
  end

  private

  def set_flickr
    FlickRaw.api_key = FLICKR_CONFIG['api_key']
    FlickRaw.shared_secret = FLICKR_CONFIG['shared_secret']

    flickr.access_token = FLICKR_CONFIG['access_token']
    flickr.access_secret = FLICKR_CONFIG['access_secret']
  end
end

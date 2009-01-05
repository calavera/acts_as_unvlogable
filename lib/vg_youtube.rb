# ----------------------------------------------
#  Class for Youtube (youtube.com)
#  http://www.youtube.com/watch?v=25AsfkriHQc
# ----------------------------------------------


class VgYoutube
  
  def initialize(url=nil, options={})
    object = YouTubeG::Client.new rescue {}
    @url = url
    @video_id = @url.query_param('v')
    @details = object.video_by(@video_id)
    raise if @details.blank?
  end
  
  def title
    @details.title
  end
  
  def thumbnail
    @details.thumbnails.first.url
  end
  
  def embed_url
    @details.media_content.first.url if @details.noembed == false
  end
  
  # options 
  #   :nosearchbox => true | removes the searchbox on the player
  # 
  def embed_html(width=425, height=344, options={})
    "<object width='#{width}' height='#{height}'><param name='movie' value='#{embed_url}&fs=1#{'&showsearch=0' if options[:nosearchbox]}'></param><param name='allowFullScreen' value='true'></param><param name='allowscriptaccess' value='always'></param><embed src='#{embed_url}&fs=1#{'&showsearch=0' if options[:nosearchbox] == true}' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='#{width}' height='#{height}'></embed></object>" if @details.noembed == false
  end
  
  
  def flv
    doc = URI::parse(@url).read
    t = doc.split("&t=")[1].split("&")[0]
    "http://www.youtube.com/get_video.php?video_id=#{@video_id}&t=#{t}"
  end
  
end
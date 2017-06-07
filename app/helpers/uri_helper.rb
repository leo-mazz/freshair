module UriHelper
  require 'cgi'

  def escape(uri)
    CGI.escape uri
  end

  def mixcloud(uri)
    '<iframe width="100%" height="120" src="https://www.mixcloud.com/widget/iframe/?feed=' + escape(uri) + '&hide_cover=1&hide_artwork=1" frameborder="0"></iframe>'
  end
end

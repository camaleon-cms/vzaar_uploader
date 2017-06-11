$ ->
  $.fn.VzaarPlayer = ()->
    this.each ->
      video = $(this)
      src = $(this).attr('src') || $(this).find('source').attr('src')
      if src.search('vzaar.com') >= 0
        $(this).replaceWith("""<iframe id="vzvd-10456199" #{if video.attr("width") then "width='#{video.attr("width")}'" else ""} #{if video.attr("height") then "width='#{video.attr("height")}'" else ""} name="vzvd-10456199" title="video player" class="video-player" type="text/html" frameborder="0" allowfullscreen allowTransparency="true" mozallowfullscreen webkitAllowFullScreen src="#{src}"></iframe>""")
    
  $('video').not('exclude_vzaar_iframe').each ->
    $(this).VzaarPlayer()
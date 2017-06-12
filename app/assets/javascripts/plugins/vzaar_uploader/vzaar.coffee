$ ->
  $.fn.VzaarPlayer = ()->
    this.each ->
      video = $(this)
      src = $(this).attr('src') || $(this).find('source').attr('src')
      if src.search('vzaar.com') >= 0
        pattern = /\/\/view.vzaar.com\/([0-9]*)\/player/i
        match = pattern.exec($(this).attr('src'))
        $(this).replaceWith("""<iframe id="vzvd-#{match[1]}" #{if video.attr("width") then "width='#{video.attr("width")}'" else ""} #{if video.attr("height") then "width='#{video.attr("height")}'" else ""} name="vzvd-#{match[1]}" title="video player" class="embed-responsive-item" type="text/html" allowfullscreen allowTransparency="true" mozallowfullscreen webkitAllowFullScreen src="#{src}"></iframe>""")
    
  $('video').not('exclude_vzaar_iframe').each ->
    $(this).VzaarPlayer()
module ApplicationHelper
  def ugly_lyrics(lyrics)
    return if lyrics.nil?
    lyrics_arr = lyrics.split("\n")
    lyrics_arr.map! do |line|
      line = "&#9835; #{h(line)}".html_safe
    end
    output = "<pre>"
    output += lyrics_arr.join("\n")
    output += "</pre>"
    output.html_safe
  end

end


 #"<strong class=\"highlight\">#{h(text)}</strong>".html_safe

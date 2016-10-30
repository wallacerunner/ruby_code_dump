# Remove all the wubs from the given string.
def song_decoder(song)
  song.split('WUB').reject(&:empty?).join(' ')
end

def song_decoder_best(song)
  song.gsub(/(WUB)+/, ' ').strip
end

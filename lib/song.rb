class Song
  attr_accessor :name, :artist_name
  @@all = []
  
  def self.create
    # song = self.new
    # song.save
    # return song
    self.new.tap { |song| song.save }
  end

  def self.new_by_name(title)
    # song = self.new
    # song.name = title
    # return song
    self.new.tap { |song| song.name = title }
  end

  def self.create_by_name(title)
    # song = self.create
    # song.name = title
    # return song
    self.create.tap { |song| song.name = title }
  end

  def self.find_by_name(title)
    ## return self.all.select { |song| song.name == title }[0]
    ## return self.all.find { |song| song.name == title }
    return @@all.detect { |song| song.name == title }
  end

  def self.find_or_create_by_name(title)
    # song = self.find_by_name(title)
    # unless song
    #   song = self.create_by_name(title)
    # end
    return self.find_by_name(title) || self.create_by_name(title)
  end

  def self.alphabetical
    return @@all.sort_by { |song| song.name }
  end

  def self.new_from_filename(filename)
    song = self.new
    song.name, song.artist_name = self.parse_filename(filename)
    return song
  end

  def self.create_from_filename(filename)
    # song = self.new_from_filename(filename)
    # song.save
    # return song
    self.new_from_filename(filename).tap { |song| song.save }
  end

  def self.destroy_all
    @@all = []
  end

  def self.all
    @@all
  end
  
  def save
    self.class.all << self
  end

  private

    def self.parse_filename(filename)
      parsed_filename = filename.chomp(".mp3").split(" - ")
      artist_name = parsed_filename[0]
      name = parsed_filename[1]
      return name, artist_name
    end
end
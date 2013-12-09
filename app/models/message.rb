class Message
  attr_reader :id, :text

  def id= new_id
    raise "ID already set." if !self.id.nil?
    @id = new_id
    return @id
  end

  def text= txt
    @modified = true

    # Make line endings consistent.
    @text = txt.gsub /\r\n?/, "\n"

    return self.text
  end

  def filename
    # TODO: Add sharding.
    return "/tmp/#{self.id}.txt"
  end

  def load 
    self.text = File.read(self.filename)
    @modified = false
    return self
  end

  def save
    self.id = Message.gen_id if self.id.nil?
    File.open(self.filename, 'w') {|file| file.write(self.text) }
    @modified = false
    return File.readable? self.filename
  end

  def modified?
    return @modified
  end

  def self.gen_id
    return Base62::encode(SecureRandom.random_number((1.81467641e19).to_i))
  end

  def self.get id
    raise "Not a valid ID." if not Message.valid_id? id

    msg = Message.new
    msg.id = id
    msg.load

    return msg
  end

  def self.valid_id? str
    not_empty = str.is_a?(String) and !str.empty?
    # TODO: Move this line into Base62
    correct_chars = str.split.map {|c| Base62::SIXTYTWO.include? c }.include? false
    return not_empty && correct_chars
  end
end

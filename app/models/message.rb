class Message
  VALID_ID_CHARS = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
  attr_reader :id, :text

  def id= new_id
    raise "ID already set." if !self.id.nil?
    raise "Not a valid ID." if !Message.valid_id? new_id
    @id = new_id
    return @id
  end

  def text= txt
    @modified = true

    # Make line endings consistent.
    @text = txt.gsub /\r\n?/, "\n"

    return self.text
  end

  def append txt
    self.text = self.text + "\n\n" + txt
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

  # TODO: make asynchronous
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
    return (0...12).map{ VALID_ID_CHARS[SecureRandom.random_number(VALID_ID_CHARS.length)] }.join
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
    correct_chars = str.split.map {|c| VALID_ID_CHARS.include? c }.include? false
    return not_empty && correct_chars
  end
end

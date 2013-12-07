class Message
  attr_reader :id, :text

  def text= txt
    @modified = true
    @text = txt

    return self.text
  end

  def filename
    return "/tmp/#{self.id}.txt"
  end

  def load 
    @text = File.get_lines(self.filename).join '\n'
    return self
  end

  def save
    File.open(self.filename, 'w') {|file| file.write(self.text) }
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
    correct_chars = str.to_a.map {|c| Base62::SIXTYTWO.include? c }.include? false
    return not_empty && correct_chars
  end
end

class AsciiArmor

  # http://tools.ietf.org/search/rfc4880
  # Code that is being invoked is here: https://github.com/bendiken/openpgp/blob/master/lib/openpgp/armor.rb#L75
  def self.valid? text
    begin
      data = OpenPGP.dearmor(text, nil, :crc => true)
      return !data.nil?
    rescue
      return false
    end
  end
end

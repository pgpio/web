class AsciiArmor

  # http://tools.ietf.org/search/rfc4880
  # Could easily be based off of https://github.com/bendiken/openpgp/blob/master/lib/openpgp/armor.rb#L75
  def self.validate text
    require "base64"

    # Does the block have valid headers?
    # TODO: implement
    
    # Split the message and checksum

    # Is the text block length divisible by 4?
    # TODO: implement

    # Does the text block have valid characters
    # TODO: implement
    regex_64 = %r{[A-Za-z0-9+\/]+={0,3}}

    # Validate Checksum
    # https://en.wikipedia.org/wiki/Base64#OpenPGP
    # TODO: implement
  end
end

require "securerandom"

# From https://gist.github.com/dmpatierno/0a07d2f3dce09253420a
module Base62
  SIXTYTWO = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a

  def encode numeric
    raise ArgumentError unless Numeric === numeric
    return '0' if numeric == 0
    s = ''
    while numeric > 0
      s << Base62::SIXTYTWO[numeric.modulo(62)]
      numeric /= 62
    end
    s.reverse
  end

  def decode base62
    s = base62.to_s.reverse.split('')
    total = 0
    s.each_with_index do |char, index|
      if ord = SIXTYTWO.index(char)
        total += ord * (62 ** index)
      else
        raise ArgumentError, "#{base62} has #{char} which is not valid"
      end
    end
    total.to_s
  end

  module_function :encode, :decode
end

# TODO: Only rand using N - M to fix resulting character count
# p Base62::encode(SecureRandom.random_number((1.84467441e19).to_i))

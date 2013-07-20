def primes upto=1000
  cache = [2,3]
  offset = 1
  upto_sqrt = Math.sqrt upto
  last = -2
  while last < upto_sqrt
    possible_prime = cache[-1] + offset
    if cache.take_while {|el| upto_sqrt > el}.none? {|i| possible_prime % i == 0}
      offset = 0
      cache << possible_prime
      yield possible_prime if block_given?
    else
      offset += 1
    end
    last = cache[-1]
  end
end

primes(10_000_000_000) {|p| puts p.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}

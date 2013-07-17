def primes upto=1000
  cache = [2,3]
  offset = 1
  while cache[-1] < upto
    possible_prime = cache[-1] + offset
    if cache.none? {|i| possible_prime % i == 0}
      offset = 0
      cache << possible_prime
    else
      offset += 1
    end
  end
  cache
end

puts primes 10_000
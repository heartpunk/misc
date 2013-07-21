import Base.*
import Base.+
import Base./

type BinaryProbability
  p::Float64
end

type ConditionalBinaryProbability
  given::Bool
  initial::BinaryProbability
  secondary::BinaryProbability
end

complement(p) = 1 - p
complement(p::BinaryProbability) = BinaryProbability(complement(p.p))

*(x::BinaryProbability, y::BinaryProbability) = BinaryProbability(x.p * y.p)
+(x::BinaryProbability, y::BinaryProbability) = BinaryProbability(x.p + y.p)
/(x::BinaryProbability, y::BinaryProbability) = BinaryProbability(x.p / y.p)

p_given(conditional::ConditionalBinaryProbability, given::Bool) = given ? conditional.initial : complement(conditional.initial)
p_given(conditional::ConditionalBinaryProbability) = p_given(conditional, true)
p_conditioned(conditional::ConditionalBinaryProbability, desired::Bool) = desired ? conditional.secondary : complement(conditional.secondary)

function probability_of_conditioned_event(conditionals::Array{ConditionalBinaryProbability,1}, desired::Bool)
  num = BinaryProbability(0.0)
  denom = BinaryProbability(0.0)
  for conditional in conditionals
    num += p_given(conditional) * p_conditioned(conditional, desired)
    denom += sum([p_given(conditional, conditional.given) * p_conditioned(conditional, fake_desired) for fake_desired = [true, false]])
  end
  num / denom
end

P_coin_a = BinaryProbability(0.5)
P_coin_b_given_h_coin_a = ConditionalBinaryProbability(true, P_coin_a, BinaryProbability(0.9))
P_coin_c_given_t_coin_a = ConditionalBinaryProbability(false, P_coin_a, BinaryProbability(0.2))

probability_of_conditioned_event(conditional::ConditionalBinaryProbability, desired) = probability_of_conditioned_event([conditional], desired)

println(probability_of_conditioned_event([P_coin_c_given_t_coin_a, P_coin_b_given_h_coin_a], true))

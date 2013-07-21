type BinaryProbability
  positive::Float64
end

negative(p::BinaryProbability) = 1 - p.positive # this makes the syntax asymmetrical. which sucks.

negative(BinaryProbability(0.9))

type ConditionalBinaryProbability
  given::String
  initial::BinaryProbability
  secondary::BinaryProbability
end

function inverse_p (p)
  1 - p
end

P_coin_a = BinaryProbability(0.5)
P_coin_b_given_h_coin_a = ConditionalBinaryProbability("positive", P_coin_a, BinaryProbability(0.9))
P_coin_c_given_t_coin_a = ConditionalBinaryProbability("negative", P_coin_a, BinaryProbability(0.2))

function p_given(conditional::ConditionalBinaryProbability)
  if conditional.given == "positive"
    conditional.initial.positive
  elseif conditional.given == "negative"
    negative(conditional.initial)
  else
    println("this should never happen")
  end
end

function p_given(conditional::ConditionalBinaryProbability, given::String)
  if given == "positive"
    conditional.initial.positive
  elseif given == "negative"
    negative(conditional.initial)
  else
    println("this should never happen OH MY GOD")
  end
end

function p_conditioned(conditional::ConditionalBinaryProbability, desired::String)
  if desired == "positive"
    conditional.initial.positive
  elseif desired == "negative"
    negative(conditional.initial)
  else
    println("this should never happen (norly)")
  end
end

# TODO: this needs to be generalized to many conditionals and then it can replace the function below.
function total_probability_of_conditioned_event(conditional::ConditionalBinaryProbability, desired)
  num = p_given(conditional) * p_conditioned(conditional, desired)
  denom = sum([p_given(conditional, fake_given) * p_conditioned(conditional, fake_desired)
    for fake_given = ["positive", "negative"], fake_desired = "positive", "negative"])
  num / denom
end

function P_h2 (P_h_coin_a, P_h_coin_b_given_h_coin_a, P_t_coin_c_given_t_coin_a)
  denom, num = 0

  num = P_h_coin_a * P_h_coin_b_given_h_coin_a + inverse_p(P_h_coin_a) * inverse_p(P_t_coin_c_given_t_coin_a)
  denom = num + P_h_coin_a * inverse_p(P_h_coin_b_given_h_coin_a) + inverse_p(P_h_coin_a) * P_t_coin_c_given_t_coin_a

  num / denom
end

println(P_h2(0.5, 0.9, 0.8))

function P_h2 (P_h_coin_a, P_h_coin_b_given_h_coin_a, P_t_coin_c_given_t_coin_a)
  denom, num = 0

  tmp = P_h_coin_a * P_h_coin_b_given_h_coin_a
  denom += tmp
  num += tmp

  denom += P_h_coin_a * inverse_p(P_h_coin_b_given_h_coin_a)

  P_t_coin_a = inverse_p(P_h_coin_a)

  tmp = P_t_coin_a * P_t_coin_c_given_t_coin_a
  denom += tmp

  tmp = P_t_coin_a * inverse_p(P_t_coin_c_given_t_coin_a)
  denom += tmp
  num += tmp

  num / denom
end

function inverse_p (p)
  1 - p
end

println(P_h2(0.5, 0.9, 0.8))
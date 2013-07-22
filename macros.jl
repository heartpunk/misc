simple_if = quote
  if true
    1
  else
    2
  end
end

if_with_elseif = quote
  if true
    1
  elseif false
    2
  end
end

if_with_elseif_and_else = quote
  if true
    1
  elseif false
    2
  else
    3
  end
end

ifs = [simple_if, if_with_elseif, if_with_elseif_and_else]

for an_if in ifs
  println(an_if.args[2].args)
end

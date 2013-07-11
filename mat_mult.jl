function col (n, mat)
  mat[:,n]
end

function row(n, mat)
  mat[n,:]
end

function mat_mult(foo, bar)
  [(row(row_i, foo) * col(col_i, bar))[1] for row_i=1:size(foo)[1], col_i=1:size(bar)[2]]
end

succeeded = true
for i = 1:100000
  a = rand(3,4)
  b = rand(4,3)
  if mat_mult(a,b) != a * b
    println(a,b,"failed")
    succeeded = false
    break
  end
end

if succeeded
  println("yay, it worked!")
end

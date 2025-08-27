def m(n)
  return 0.01 if n <= 1
  return 100 if n >= 10_000_000

  min_val = 0.01
  max_val = 100.0
  alpha   = 0.6  # regulacja kształtu

  ratio = (n - 1).to_f / (10_000_000.0 - 1)
  min_val + (max_val - min_val) * (ratio ** alpha)
end

# test
[ 1, 20, 400, 5000, 10_000, 100_000, 1_000_000, 10_000_000 ].each do |n|
  puts "n=#{n} -> m=#{m(n)}"
end

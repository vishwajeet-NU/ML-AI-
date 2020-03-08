function W = randomWeights(a, b)

W = zeros(b, 1 + a); #mat to store randomly initialized weights

epsilon = 0.1;
W = rand(b, 1 + a) * 2 * epsilon - epsilon; #weight values

end

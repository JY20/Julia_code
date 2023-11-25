using LinearAlgebra

A = [1 1 0; 0 1 1; -1 1 -1]

display(A)
U, S, V = svd(A);
display(U);
display(diagm(S));
display(V')
display(U * diagm(S) * V')

println("********************************")

inv_A = inv(A)

display(inv_A)
inv_U, inv_S, inv_V = svd(inv_A);
display(inv_U);
display(diagm(inv_S));
display(inv_V')
display(inv_U * diagm(inv_S) * inv_V')

println("********************************")
det_A = prod(S)
println("det of A: ", det_A)
println("real det of A: ", det(A))
# 1) The singular values of A and A^-1 they are related by the value A^-1 are the recipricol of the values of A. The SVD of A^-1=(V)*(S^−1)*trans(U) and SVD of A=(U)*(S)*trans(V)
# 2) The U and V are orthogonal with determinants of +-1, their only impact are on the sign from multiplication. We know that determinant of any diagonal matrix equals the product of its diagonal elements, we can determine the value of the determinant of A by multiplying its singular values, since that S is a diagonal matrix.
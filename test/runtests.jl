using pindex
using Test

@testset "pindex.jl" begin
    # T3: Identity or Constant test P(p,p,q^0,q^1)=1
    a=[1 2 3; 1 2 3; 1 2 3] b=rand(3,3)
    @test FixedLaspeyres(a,b)==1

end

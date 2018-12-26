using pindex
using Test

    # T3: Identity or Constant test P(p,p,q^0,q^1)=1
    p=[1 2 3; 1 2 3; 1 2 3] q=rand(3,3)
    @test FixedLaspeyres(p,q)==1

end

using pindex
using Test

    # T3: Identity or Constant test P(p,p,q^0,q^1)=1
    p=[1 2 3; 1 2 3; 1 2 3] q=[2 4 5; 1 3 6; 9 2 5]
    @test FixedLaspeyres(p,q) == 1

end

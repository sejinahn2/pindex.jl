using pindex
using Distributions, Parameters, LinearAlgebra, Compat, Test


    # T3: Identity or Constant test P(p,p,q^0,q^1)=1
        a=[1 1 1; 2 2 2; 3 3 3]
        b=rand(3,3)
        @test FixedLaspeyres(a,b) == ones(3)
        @test FixedPaasche(a,b) == ones(3)
        @test FixedFisher(a,b) == ones(3)
        @test FixedTornqvist(a,b) == ones(3)

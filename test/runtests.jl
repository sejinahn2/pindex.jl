using pindex
using Distributions, Parameters, LinearAlgebra, Compat, Test

    #Tests are referred from Professor Erwin Diewerts 580 Lecture note 3
    # T3: Identity or Constant test: P(p,p,q0,q1)=1
        a=[1 1 1; 2 2 2; 3 3 3]
        b=rand(3,3)
        @testset "T3" begin
        @test FixedLaspeyres(a,b) ≈ ones(3)
        @test FixedPaasche(a,b) ≈ ones(3)
        @test FixedFisher(a,b) ≈ ones(3)
        @test FixedTornqvist(a,b) ≈ ones(3)
        end 

    #T5: Propotionality in Current Prices: P(p0,k*p1,q0,q1)=k*P(p0,p1,q0,q1)
        a=rand(3,3)
        b=rand(3,3)
        k=5
        c=[a[:,1] k*a[:,2] k*a[:,3]]
        @test FixedLaspeyres(a,b)[2]*k ≈ FixedLaspeyres(c,b)[2]
        @test FixedPaasche(a,b)[2]*k ≈ FixedPaasche(c,b)[2]
        @test FixedFisher(a,b)[2]*k ≈ FixedFisher(c,b)[2]
        #Note that Fixed Tornqvist does not satisfies T5

    #T9 Commodity Reversal Test
    #T16 Paasche and Laspeyres Bounding Test: The price index P lies between the
    #Laspeyers and Paashce indices
        @test FixedFisher(a,b) < max(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test FixedFisher(a,b) > min(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test FixedTornqvist(a,b) < max(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test FixedTornqvist(a,b) > min(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test ChainedFisher(a,b) < max(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
        @test ChainedFisher(a,b) > min(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
        @test ChainedTornqvist(a,b) < max(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
        @test ChainedTornqvist(a,b) > min(ChainedLaspeyres(a,b),ChainedPaasche(a,b))

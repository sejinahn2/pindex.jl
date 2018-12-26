using pindex
using Distributions, Parameters, LinearAlgebra, Compat, Test

    #Tests are referred from Professor Erwin Diewerts 580 Lecture note 3
    # T3: Identity or Constant test: P(p,p,q0,q1)=1

        l=rand(3)
        a=[l'; l'; l']'
        b=rand(3,3)
        @testset "T3" begin
        @test FixedLaspeyres(a,b) ≈ ones(3)
        @test FixedPaasche(a,b) ≈ ones(3)
        @test FixedFisher(a,b) ≈ ones(3)
        @test FixedTornqvist(a,b) ≈ ones(3)
        @test ChainedLaspeyres(a,b) ≈ ones(3)
        @test ChainedPaasche(a,b) ≈ ones(3)
        @test ChainedFisher(a,b) ≈ ones(3)
        @test ChainedTornqvist(a,b) ≈ ones(3)

    end

    #T5: Propotionality in Current Prices: P(p0,k*p1,q0,q1)=k*P(p0,p1,q0,q1)
        a=rand(3,3)
        b=rand(3,3)
        k=5
        c=[a[:,1] k*a[:,2] k*a[:,3]]
        @testset "T5" begin
        @test FixedLaspeyres(a,b)[2]*k ≈ FixedLaspeyres(c,b)[2]
        @test FixedPaasche(a,b)[2]*k ≈ FixedPaasche(c,b)[2]
        @test FixedFisher(a,b)[2]*k ≈ FixedFisher(c,b)[2]
        @test ChainedLaspeyres(a,b)[2]*k ≈ ChainedLaspeyres(c,b)[2]
        @test ChainedPaasche(a,b)[2]*k ≈ ChainedPaasche(c,b)[2]
        @test ChainedFisher(a,b)[2]*k ≈ ChainedFisher(c,b)[2]
        #Note that Fixed Tornqvist does not satisfies T5
    end

    #T9 Commodity Reversal Test
    #T16 Paasche and Laspeyres Bounding Test: The price index P lies between the
    #Laspeyers and Paashce indices
        @testset "T16" begin
        @test FixedFisher(a,b) < max(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test FixedFisher(a,b) > min(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test FixedTornqvist(a,b) < max(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test FixedTornqvist(a,b) > min(FixedLaspeyres(a,b),FixedPaasche(a,b))
        @test ChainedFisher(a,b) < max(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
        @test ChainedFisher(a,b) > min(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
        @test ChainedTornqvist(a,b) < max(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
        @test ChainedTornqvist(a,b) > min(ChainedLaspeyres(a,b),ChainedPaasche(a,b))
    end

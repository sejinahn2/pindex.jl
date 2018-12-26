module pindex

greet() = print("Hello World!")

using Distributions, Parameters, LinearAlgebra, Compat, Test

function FixedLaspeyres(p,q)
N=size(p,1)
T=size(p,2)
Pl=zeros(N+1,T)
s=zeros(N,T)
   for t in 1:T
        for n in 2:N+1
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/p[:,t]'q[:,t]
        Pl[n,t]=Pl[n-1,t]+p[n-1,t]/p[n-1,1]*s[n-1,1]
        end
    end
return Pl[N+1,:]
end

function FixedPaasche(p,q)
N=size(p,1)
T=size(p,2)
Pp=zeros(N+1,T)
s=zeros(N,T)
   for t in 1:T
        for n in 2:N+1
        s[n-1,t] = p[n-1,t]*q[n-1,t]/p[:,t]'q[:,t]
        Pp[n,t]=Pp[n-1,t]+p[n-1,1]/p[n-1,t]*s[n-1,t]
        end
    end
return Pp[N+1,:].^(-1)
end

function FixedFisher(p,q)
     Pf=(FixedPaasche(p,q).^(1/2)).*(FixedLaspeyres(p,q).^(1/2))
return Pf
end

function FixedTornqvist(p,q)
N=size(p,1)
T=size(p,2)
Pt=zeros(N+1,T)
s=zeros(N,T)
   for t in 1:T
        for n in 2:N+1
        s[n-1,t] = p[n-1,t]*q[n-1,t]/p[:,t]'q[:,t]
        Pt[n,t]=(1/2)*(s[n-1,1]+s[n-1,t])*log(p[n-1,t]/p[n-1,1])
        end
    end
return exp.(Pt[N+1,:])
end

function ChainedLaspeyres(p,q)
N=size(p,1)
T=size(p,2)
Pl=zeros(N+1,T)
Plc=ones(N+1,T)
s=zeros(N,T)
   for t in 2:T
        for n in 2:N+1
        s[n-1,t-1] = p[n-1,t-1]*q[n-1,t-1]/p[:,t-1]'q[:,t-1]
        Pl[n,t]=Pl[n-1,t]+p[n-1,t]/p[n-1,t-1]*s[n-1,t-1]
        Plc[n,t]=Plc[n,t-1]*Pl[n,t]
        end
    end
return Plc[N+1,:]
end

function ChainedPaasche(p,q)
N=size(p,1)
T=size(p,2)
Pp=zeros(N+1,T)
Ppc=ones(N+1,T)
s=zeros(N,T)
   for t in 2:T
        for n in 2:N+1
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/p[:,t]'q[:,t]
        Pp[n,t]=Pp[n-1,t]+p[n-1,t-1]/p[n-1,t]*s[n-1,t]
        Ppc[n,t]=Ppc[n,t-1]*(Pp[n,t])^(-1)
        end
    end
return Ppc[N+1,:]
end

function ChainedFisher(p,q)
     Pfc=(ChainedPaasche(p,q).^(1/2)).*(ChainedLaspeyres(p,q).^(1/2))
return Pfc
end

function ChainedTornqvist(p,q)
N=size(p,1)
T=size(p,2)
Pt=zeros(N+1,T)
Ptc=ones(N+1,T)
s=zeros(N,T)
   for t in 2:T
        for n in 2:N+1
        s[n-1,t-1] = p[n-1,t-1]*q[n-1,t-1]/p[:,t-1]'q[:,t-1]
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/p[:,t]'q[:,t]
        Pt[n,t]=Pt[n-1,t]+(1/2)*(s[n-1,t-1]+s[n-1,t])*log(p[n-1,t]/p[n-1,t-1])
        Ptc[n,t]=Ptc[n,t-1]*exp(Pt[n,t])
        end
    end
return Ptc[N+1,:]
end

function FixLaspeyres(p,q)
N=size(p,1)
T=size(p,2)
Pl=zeros(T)
    for t in 1:T
    Pl[t]=p[:,t]'q[:,1]/p[:,1]'q[:,1]
    end
return Pl
end

function FixPaasche(p,q)
N=size(p,1)
T=size(p,2)
Pl=zeros(T)
    for t in 1:T
    Pl[t]=p[:,t]'q[:,t]/p[:,1]'q[:,t]
    end
return Pl
end

function FixFisher(p,q)
     Pf=(FixPaasche(p,q).^(1/2)).*(FixLaspeyres(p,q).^(1/2))
return Pf
end

function ChainLaspeyres(p,q)
N=size(p,1)
T=size(p,2)
Pl=ones(T)
Plc=ones(T)
    for t in 2:T
    Pl[t]=p[:,t]'q[:,t-1]/p[:,t-1]'q[:,t-1]
    Plc[t]=Plc[t-1]*Pl[t]
    end
return Plc
end

function ChainPaasche(p,q)
N=size(p,1)
T=size(p,2)
Pp=ones(T)
Ppc=ones(T)
    for t in 2:T
    Pp[t]=p[:,t]'q[:,t]/p[:,t-1]'q[:,t]
    Ppc[t]=Ppc[t-1]*Pp[t]
    end
return Ppc
end

function ChainFisher(p,q)
    Pfc=(ChainPaasche(p,q).^(1/2)).*(ChainLaspeyres(p,q).^(1/2))
return Pfc
end

export FixedLaspeyres,  FixedPaasche, FixedFisher, FixedTornqvist, ChainedLaspeyres, ChainedPaasche, ChainedFisher, ChainedTornqvist, FixLaspeyres, FixPaasche, FixFisher, ChainLaspeyres, ChainPaasche, ChainFisher

end # module

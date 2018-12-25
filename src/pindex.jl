module pindex

greet() = print("Hello World!")

function FixedLaspeyres(p,q)
N=size(p,1)
T=size(p,2)
Pl=zeros(N+1,T)
s=zeros(N,T)
   for t in 1:T
        for n in 2:N+1
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/dot(p[:,t],q[:,t])
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
        s[n-1,t] = p[n-1,t]*q[n-1,t]/dot(p[:,t],q[:,t])
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
        s[n-1,t] = p[n-1,t]*q[n-1,t]/dot(p[:,t],q[:,t])
        Pt[n,t]=(1/2)*(s[n-1,1]+s[n-1,t])*log(p[n-1,t]/p[n-1,1])
        end
    end
return exp.(Pt[N+1,:])
end

function ChainedLaspeyres(p,q)
N=size(p,1)
T=size(p,2)
Pl=ones(N+1,T)
Plc=ones(N+1,T)
s=zeros(N,T)
   for t in 2:T
        for n in 2:N+1
        s[n-1,t-1] = p[n-1,t-1]*q[n-1,t-1]/dot(p[:,t-1],q[:,t-1])
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/dot(p[:,t],q[:,t])
        Pl[n,t]=Pl[n-1,t]+p[n-1,t]/p[n-1,t-1]*s[n-1,t-1]
        Plc[n,t]=Plc[n,t-1]*Pl[n,t]
        end
    end
return Plc[N+1,:]
end

function ChainedPaasche(p,q)
N=size(p,1)
T=size(p,2)
Pp=ones(N+1,T)
Ppc=ones(N+1,T)
s=zeros(N,T)
   for t in 2:T
        for n in 2:N+1
        s[n-1,t-1] = p[n-1,t-1]*q[n-1,t-1]/dot(p[:,t-1],q[:,t-1])
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/dot(p[:,t],q[:,t])
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
Pt=ones(N+1,T)
Ptc=ones(N+1,T)
s=zeros(N,T)
   for t in 2:T
        for n in 2:N+1
        s[n-1,t-1] = p[n-1,t-1]*q[n-1,t-1]/dot(p[:,t-1],q[:,t-1])
        s[n-1,t] = (p[n-1,t]*q[n-1,t])/dot(p[:,t],q[:,t])
        Pt[n,t]=(1/2)*(s[n-1,t-1]+s[n-1,t])*log(p[n-1,t]/p[n-1,t-1])
        Ptc[n,t]=Ptc[n,t-1]*exp(Pt[n,t])
        end
    end
return Ptc[N+1,:]
end

export FixedLaspeyres,  FixedPaasche, FixedFisher, FixedTornqvist, ChainedLaspeyres, ChainedPaasche, ChainedFisher, ChainedTornqvist


end # module

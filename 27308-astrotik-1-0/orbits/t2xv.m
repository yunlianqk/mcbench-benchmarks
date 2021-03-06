% ASTROTIK by Francesco Santilli
% R2BP (Restricted Two Bodies Problem)
% t2xv computes orbital position and velocity vectors of a time span
%
% Usage: [X,V] = t2xv(orbits,t0,t,mi)
%
% where: orbits(k,:) = [p e i o w] = 3d orbit elements
%        orbits(k,:) = [p e w]     = 2d orbit elements
%           p = semi-latus rectum [L] (p>0)
%           e = eccentricity [-] (e>=0)
%           i = inclinaion [rad]
%           o = raan [rad]
%           w = argument of perifocus [rad]
%        t0(k) = time of periapsis [T]
%        t(j) = time [T]
%        mi = gravitational parameter [L^3*T^-2] (mi>0)
%        X(j,:,k) = position [L]
%        V(j,:,k) = velocity [L*T^-1]

function [X,V] = t2xv(orbits,t0,t,mi)

    if ~(nargin == 4)
        error('Wrong number of input arguments.')
    end
    
    [K,D] = check(orbits,2);
    check(t0,1)
    J = check(t,1);
    check(mi,0)
    
    if D < 3
        error('Wrong size of input arguments.')
    end
    
    p = orbits(:,1);
    e = orbits(:,2);
    c = sqrt(mi./p.^3);
    f = t2f(t0,c,e,t);
    
    d3 = (D==5);
    X = zeros(J,2+d3,K);
    V = zeros(J,2+d3,K);
    for k = 1:K
        [X(:,:,k), V(:,:,k)] = f2xv(orbits(k,:),f(:,k),mi);
    end

end

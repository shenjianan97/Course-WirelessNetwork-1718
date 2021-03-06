% Question 1
 
N = input('the cluster size N = '); 
n = input('the path loss exponent n = ');
M = 100000;

%*** call function to get the randomly lacation of the user ***%
PosMSs = genPosition(M);

%*** call function to get the lacation of 18 co-interference cells ***%
PosCells = locateCells(N);

%*** ds is the '-n' power of the distance between MS and BaseStation ***%
ds = (abs(PosMSs)).^-n; 

%*** calculate the '-n' power of the distance between MS and BaseStation of the co-interference cell ***%
ditemp1 = abs(PosMSs*(ones(18,1))'-ones(M,1)*PosCells'); 
ditemp2 = ditemp1.^-n; 

%*** add the distance of inteference togather. ***%
di = ditemp2*ones(18,1); 

%*** the SIR  ***%
SIR = 10*log(ds./di); 

%EverageSIR = SIR*ones(1,M)/M 
hist(SIR, -20:250) 
title('Histogram'); 
xlabel('SIR(dB)'); 
ylabel('numbers of MS');
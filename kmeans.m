load 'newrefnp300.mat';
load 'newrefp300.mat';
%--------------------------------------------------------
%Kmeans

%Parametres à ajuster 
MaxIterations=30;
K=6;

%Initialisation
p300means=zeros(K,2);
np300means=zeros(K,2);
x=randperm(size(newrefp300,1),K);
y=randperm(size(newrefnp300,1),K);
for i=1:K
  p300means(i,1)=newrefp300(x(i),1);
  p300means(i,2)=newrefp300(x(i),2);
  np300means(i,1)=newrefnp300(x(i),1);
  np300means(i,2)=newrefnp300(x(i),2);
endfor

%Recalcul des kmeans pour MaxIterations

for i=1:MaxIterations
   newp300means=p300means;
   newnp300means=np300means;
   nbrp300=ones(K,1);
   nbrnp300=ones(K,1);  
   Distancep300=zeros(K,1);
   Distancenp300=zeros(K,1);
   
   %Les P300
    for j=1:size(newrefp300,1)
      for k=1:K
          Distancep300(k,1)=sqrt((p300means(k,1)-newrefp300(j,1))^2 + (p300means(k,2)-newrefp300(j,2))^2);
      endfor
     [val,idx]=min(Distancep300);
     nbrp300(idx,1)=nbrp300(idx,1)+1;
     newp300means(idx,:)=newp300means(idx,:)+newrefp300(j,:);
    endfor
   
    for a=1:K
      p300means(K,1)=newp300means(K,1)/nbrp300(K);
      p300means(K,2)=newp300means(K,2)/nbrp300(K);
    endfor
 
   %Les NP300
    for j=1:size(newrefnp300,1)
      for k=1:K
          Distancenp300(k,1)=sqrt((np300means(k,1)-newrefnp300(j,1))^2 + (np300means(k,2)-newrefnp300(j,2))^2);
      endfor
     [val,idx]=min(Distancenp300);
     nbrnp300(idx,1)=nbrnp300(idx,1)+1;
     newnp300means(idx,:)=newnp300means(idx,:)+newrefnp300(j,:);
    endfor
    
    for a=1:K
      np300means(a,1)=newnp300means(a,1)/nbrnp300(a);
      np300means(a,2)=newnp300means(a,2)/nbrnp300(a);
    endfor        
endfor
%-------------------------------------------------------------

%Utilisation des KPPV:
load testp300.mat;
load testnp300.mat;

%Modifier le K pour tester les différentes valeurs
K=5;
T=0;
N=6;

DistP300=zeros(1,N);
DistNP300=zeros(1,N);
for i=1:size(testp300,1)
  for j=1:N
    DistP300(:,j)=sqrt((testp300(i,1)-p300means(j,1))^2+ (testp300(i,2)-p300means(j,2))^2);
    DistNP300(:,j)=sqrt((testp300(i,1)-np300means(j,1))^2+ (testp300(i,2)-np300means(j,2))^2);
  endfor
  DistP300=sort(DistP300);
  DistNP300=sort(DistNP300);
  if(DistP300(1,K)<DistNP300(1,K))
    T=T+1;
  endif
endfor


for i=1:size(testnp300,1)
  for j=1:N
    DistP300(:,j)=sqrt((testnp300(i,1)-p300means(j,1))^2 + (testnp300(i,2)-p300means(j,2))^2);
    DistNP300(:,j)=sqrt((testnp300(i,1)-np300means(j,1))^2 + (testnp300(i,2)-np300means(j,2))^2);
  endfor
  DistP300=sort(DistP300);
  DistNP300=sort(DistNP300);
  if(DistP300(1,K)>DistNP300(1,K))
    T=T+1;
  endif
endfor

T=T*100/(size(testp300,1)+size(testnp300,1));

printf("\nTaux de classification avec kppv T=");
disp(T);






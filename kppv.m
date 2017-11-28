load newrefnp300.mat;
load newrefp300.mat;
load testp300.mat;
load testnp300.mat;

%===================================================
%KPPV
%Modifier le K pour tester les différentes valeurs
K=9;
T=0;
N=min(size(newrefp300,1),size(newrefnp300,1));

DistP300=zeros(1,N);
DistNP300=zeros(1,N);
for i=1:size(testp300,1)
  for j=1:N
    DistP300(:,j)=sqrt((testp300(i,1)-newrefp300(j,1))^2+ (testp300(i,2)-newrefp300(j,2))^2);
    DistNP300(:,j)=sqrt((testp300(i,1)-newrefnp300(j,1))^2+ (testp300(i,2)-newrefnp300(j,2))^2);
  endfor
  DistP300=sort(DistP300);
  DistNP300=sort(DistNP300);
  if(DistP300(1,K)<DistNP300(1,K))
    T=T+1;
  endif
endfor


for i=1:size(testnp300,1)
  for j=1:N
    DistP300(:,j)=sqrt((testnp300(i,1)-newrefp300(j,1))^2 + (testnp300(i,2)-newrefp300(j,2))^2);
    DistNP300(:,j)=sqrt((testnp300(i,1)-newrefnp300(j,1))^2 + (testnp300(i,2)-newrefnp300(j,2))^2);
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


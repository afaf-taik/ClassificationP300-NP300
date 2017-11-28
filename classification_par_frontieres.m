load 'newrefnp300.mat';
load 'newrefp300.mat';
load 'testnp300.mat' ;
load 'testp300.mat' ;


cv1=cov(newrefp300);
cv2=cov(newrefnp300);
m1=mean(newrefp300);
m2=mean(newrefnp300);


%Classification par frontieres
R=0;

for i=1:size(testp300)
  c=classfrontiere(cv1,cv2,m1,m2,testp300(i,:));
  if c==1
    R=R+1;
  endif
endfor
for i=1:size(testnp300,1)
  c=classfrontiere(cv1,cv2,m1,m2,testnp300(i,:));
  if c==0
    R=R+1;
  endif
endfor

R=R*100/(size(testnp300,1)+size(testp300,1));
printf("Taux de classification avec la frontiere : ");
disp(R);

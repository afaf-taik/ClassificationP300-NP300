
1;
load ref_P300;
load ref_NP300;
load test_NP300;
load test_P300;

%Etude preliminaire et traitement
ref=[ref_P300;ref_NP300];
cv=cov(ref);
disp(cv);
[vectp,valp]=eig(cv);
disp(valp);
%Rotation et réduction de dimensions
newrefp300=ref_P300*vectp;
newrefnp300=ref_NP300*vectp;
newref=[newrefp300;newrefnp300];
newrefp300(:,1)=[];
newrefnp300(:,1)=[];
newrefp300(:,1)=[];
newrefnp300(:,1)=[];
test_P300=test_P300*vectp;
test_NP300=test_NP300*vectp;
test_P300(:,1)=[];
test_P300(:,1)=[];
test_NP300(:,1)=[];
test_NP300(:,1)=[];
testp300=test_P300;
testnp300=test_NP300;

%Uncomment pour afficher le nouvel arrangement des points
%plot(newrefp300(:,1),newrefp300(:,2),'+r',newrefnp300(:,1),newrefnp300(:,2),'xb');

save('newrefp300.mat','newrefp300');
save('newrefnp300.mat','newrefnp300');
save('testp300.mat','testp300');
save('testnp300.mat','testnp300');

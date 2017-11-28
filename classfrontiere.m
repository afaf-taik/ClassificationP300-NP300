function c=classfrontiere(cv1,cv2,m1,m2,x)
  z=0.5*((x-m2).*inv(cv2).*(x-m2)'-(x-m1).*inv(cv1).*(x-m1)')-log(abs(det(cv1)/det(cv2)));
  if z>0
    c=1;
  else
    c=0;
  endif
endfunction
%Compute the paramterization of the inverse matrix of p
function pinv=AffineInverse(p)
    pinv=zeros(6, 1);
    pinv(1)=-p(1)-p(1)*p(4)+p(2)*p(3);
    pinv(2)=-p(2);
    pinv(3)=-p(3);
    pinv(4)=-p(4)-p(1)*p(4)+p(2)*p(3);
    pinv(5)=-p(5)-p(4)*p(5)+p(3)*p(6);
    pinv(6)=-p(6)-p(1)*p(6)+p(2)*p(5);
    pinv=pinv/((1+p(1))*(1+p(4))-p(2)*p(3));
end
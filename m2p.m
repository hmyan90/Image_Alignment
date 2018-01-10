%Matrix to parameter vector transformation
function p=m2p(m)
    m(1, 1)=m(1, 1)-1;
    m(2, 2)=m(2, 2)-1;
    m=m(1:2, :);
    p=m(:);
end
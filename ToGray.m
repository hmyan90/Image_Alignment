%RGB to 1 channel
function Io=ToGray(I)
    if(size(I, 3)>1)
        Io=rgb2gray(I);
    else
        Io=I;
    end
end
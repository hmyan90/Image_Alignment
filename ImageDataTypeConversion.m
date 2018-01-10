%Convert RGB data into 1 channel image
function Io=ImageDataTypeConversion(I)
    Io=ToGray(I);
    Io=im2double(Io);
end
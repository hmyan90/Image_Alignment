%Lucas Kanade inverse compositional algorithm
function p=LucasKanadeIC(T, I, pini, max_iter, window)
    T=ImageDataTypeConversion(T);   %template image(small piece)
    I=ImageDataTypeConversion(I);   %Whole image
    T=imfilter(T, fspecial('gaussian', [5, 5], 3), 'replicate'); %Smooth data
    zonex=window(1, 1):window(2, 1); %10:238, 229
    zoney=window(1, 2):window(3, 2); %70:384, 315
    %       70 71 .... 384
    %       70 71 .... 384
    %maskx=[..............] 229 X 315
    %       70 71 .... 384
    %       70 71 .... 384
    %
    %       10   10   10  ...  10  10
    %       11   11   11  ...  11  11
    %masky=[...  ...  ...  ...  ... ..] 229 X 315
    %       237  237  237 ...  237 237
    %       238  238  238 ...  238 238
    [maskx, masky]=meshgrid(zoney, zonex);
    N=numel(maskx); %72135
    %Image gradient
    DTx=imfilter(T, [-1 1], 'replicate');   %315 X 229
    DTy=imfilter(T, [-1, 1]', 'replicate'); %315 X 229
    % dx1,1       dy1,1
    % dx2,1       dy2,1
    % .            .
    % dx315,1     dy315,1
    %[.            .       ]
    % .            .
    % dx1,229     dy1,229
    % dx2,229     dy2,229
    % .            .
    % dx315,229   dy315,229
    DTx=reshape(DTx, N, 1);
    DTy=reshape(DTy, N, 1);
    %   70  10   
    %   70  11
    %   .   .
    %   .   .
    %   70  238
    %   71  10
    %   71  11
    %   .   .
    %x=[.   .]
    %   71  238
    %   .   .
    %   .   .
    %   .   .
    %   384 10
    %   384 11
    %    .  .
    %    .  .
    %   384 384
    x=[reshape(maskx, N, 1) reshape(masky, N, 1)];  %N X 2
    v0=zeros(N, 1); v1=ones(N, 1);
    dWx=[x(:, 1) v0 x(:, 2) v0 v1 v0];
    dWy=[v0 x(:, 1) v0 x(:, 2) v0 v1];
    %Jacobian: H=(\nabla T) * (\frac{\partial w}{\partial p})
    J=dWx.*DTx(:, ones(1, 6)) + dWy.*DTy(:, ones(1, 6));
    %The Hessian matrix
    H=J'*J;
    %H^{-1} * (J'), dimension: (6*6)*(6*N)=6*N
    R=H\J';
    p=pini;
    T=reshape(T, N, 1);
    I=imfilter(I, fspecial('gaussian', [5 5], 3));  %Smooth data
    
    for iter=1:max_iter
        Iw=AffineWarp(I, p, window);
        imshow(Iw); pause(0.5);
        error=Iw(:)-T;
        deltap=R*error;
        p=m2p(p2m(p)*inv(p2m(deltap)));
        converg=norm(abs(deltap))
        if converg<5e-2
            break;
        end
    end
end
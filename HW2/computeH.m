

function [ homo ] = computeH( imgPoints )
eucDist = 10000000;
bestHomo = []
for ct = 1:20
    randomPoints = datasample(imgPoints, 4, 1);
    A = []
    b = []
    for i = 1:4
        
        x1 =randomPoints(i, 1), 
        y1 =randomPoints(i, 2);
        x2 = randomPoints(i, 3);
        y2 = randomPoints(i, 4);
        
        %Ar1 = [0 0 0 -x1 -y1 -1 y2*x1  y2*y1 1];
        %Ar2 = [x1 y1 1 0 0 0 -x2*x1 -x2*y1 -x2];
        Ar1 = [x1 y1 1 0 0 0 -x1*x2 -y1*x2];
        Ar2 = [0 0 0 x1 y1 1 -x1*y2 -y1*y2];
        
        
        A = [A; Ar1; Ar2]
        b = [b; x2; y2]
        
    end
    %{
    [U, S, V] = svd(A);
    V;
    h = V(:, end);
    h = h/h(end)
    
    %h = reshape(h,3,3)
    [x1 y1]
    calcx2 = h * [x1 y1 1]'
    calcx2 = calcx2/calcx2(3)
    [x2 y2 1]'
    %}
    h = (A'* A)\(A' * b)
    h = [h;1]
    %h = reshape(h,[3,3])
    h = [h(1:3)'; h(4:6)'; h(7:9)'];
    [x1 y1];
    p2p = h * [x1 y1 1]';
    p2p = p2p/p2p(3);
    p2 = [x2 y2 1]';
    newDist = sqrt(sum((p2 - p2p) .^ 2));
    if newDist < eucDist
        eucDist = newDist;
        bestHomo = h;
    end
    
homo = bestHomo  
    
    
    
end

imgPoints = round([374.3143  290.3926  815.3587  320.2934;
  529.1366  313.4801  984.8769  329.9408;
  440.8607  301.2573  889.7813  327.1844;
  503.3329  397.6817  960.0693  420.9017;
  519.6300  371.8780  977.9859  393.3378;
  326.7812  507.6870  782.2820  536.6703;
  296.9032  460.1538  749.2052  492.5680;
  446.2931  507.6870  909.0760  539.4266;
  315.9164  590.5305  778.1474  622.1184;
  180.1074  507.6870  637.5713  540.8048
  ]);
end
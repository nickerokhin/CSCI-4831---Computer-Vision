

function [ homo ] = computeH( imgPoints )
eucDist = 10000000;
bestHomo = [];
for ct = 1:20
    randomPoints = datasample(imgPoints, 4, 1);
    A = [];
    b = [];
    for i = 1:4
        
        x1 =randomPoints(i, 1);
        y1 =randomPoints(i, 2);
        x2 = randomPoints(i, 3);
        y2 = randomPoints(i, 4);
        
        %Ar1 = [0 0 0 -x1 -y1 -1 y2*x1  y2*y1 1];
        %Ar2 = [x1 y1 1 0 0 0 -x2*x1 -x2*y1 -x2];
        Ar1 = [x1 y1 1 0 0 0 -x1*x2 -y1*x2];
        Ar2 = [0 0 0 x1 y1 1 -x1*y2 -y1*y2];
        
        
        A = [A; Ar1; Ar2];
        b = [b; x2; y2];
        
    end
    h = (A'* A)\(A' * b);
    h = [h;1];
    h = [h(1:3)'; h(4:6)'; h(7:9)'];
    [x1 y1];
    eucSum = 0
    for pts = 1:10
        x1 = imgPoints(pts, 1);
        y1 = imgPoints(pts, 2);
        x2 = imgPoints(pts, 3);
        y2 = imgPoints(pts, 4);
        
        p2p = h * [x1 y1 1]';
        p2p = p2p/p2p(3);
        p2 = [x2 y2 1]';
        
        newDist = sqrt(sum((p2 - p2p) .^ 2));
        eucSum = eucSum + newDist;
        
    end
    if eucSum < eucDist
            eucDist = eucSum
            bestHomo = h;
    end

    
homo = bestHomo;

    
    
    
end

imgPoints = [528.0000  313.0000  984.0000  335.0000;
  442.0000  303.0000  890.0000  327.0000;
  502.0000  399.0000  958.0000  423.0000;
  314.0000  617.0000  778.0000  649.0000;
  182.0000  503.0000  640.0000  539.0000;
  494.0000  371.0000  952.0000  393.0000;
  374.0000  291.0000  816.0000  319.0000;
  320.0000  459.0000  776.0000  493.0000;
  464.0000  495.0000  924.0000  533.0000;
  112.0000  573.0000  576.0000  607.0000]
end
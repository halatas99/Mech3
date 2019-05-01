function [a, b, c, d, e, f, g, h] = mech306_lab3b()
    clear
    clf
    %format long
    format short
    
    PlossMultiplier = 1;
    PlossAdd = 0;
    
    l1= .158; %black rod, len, m
    d1 = .009; %diam, m
    l2 = .157; %silver rod, len, m
    d2 = .009; %m
    
    %black paint, low fan
    v = 2.16; %m/s
    T = [39.458 42.220 49.531 60.179]; %C
    T = T+273.15;
    Tsurr = 33.5+273.15; %C
    V = [.99 4 7 10.01]; %V
    V = PlossMultiplier*V;
    V = V+PlossAdd;
    i = [.05 .26 .46 .65]; %A
    A1 = d1*l1*pi+2*pi*((d1/2)^2); %surface area of rod, m^2, 
    
    %{
    Since dT/dt = 0, we can simplify our equation to:
    q{elec} = q{radiation} + q{convection}
    (I)(V) = (epsilon)(sigma)(A)(T^4 - Tsurr^4) + (h)(A)(T - Tsurr)
    this can be simplified to:
    (I)(V) = (a)(T^4) - (a)(Tsurr^4) + (b)(T) - (b)(Tsurr)
    %}
    
    %func getCoeff solves for a & b, given a set of IV, a set of T, and Tsurr
    CoeffSet = getCoeffSet(T, i.*V, Tsurr);
    
    %NOTE that our y = IV, x = T is very linear, 
    %so trying to make it fit a n=4 polynomial is either going to give you:
    %1. weird a & b
    %2. weird theoretical plot (r value is low)
    
    %NOTE that the way matlab interpolate plots, there can be multiple values
    %run this code multiple times and compare h to h from Whitaker approximation
    
    %func CoeffSetToValSet solve (a) = (epsilon)(sigma)(A) and (b) = (h)(A)
    %for epsilon and h, respectively, and output them in a matrix
    ValSet = CoeffSetToValSet(CoeffSet, A1);
    
    %func getBestVal compares 100 e&h's to h from Whitaker approximation and returns the closest matching pair
    [a, b] = getBestVal(ValSet);
    
    %silver metal / no paint
    T = [43.64 51.99]; %C
    T = T+273.15;
    Tsurr = 33.5+273.15; %C
    V = [4 7]; %V
    V = V*PlossMultiplier;
    V = V+PlossAdd;
    i = [.26 .46]; %A
    A2 = d2*l2*pi+2*pi*((d2/2)^2); %surface area of rod, m^2

    CoeffSet2 = getCoeffSet(T, i.*V, Tsurr);
    ValSet2 = CoeffSetToValSet(CoeffSet2, A2); 
    [c, d] = getBestVal(ValSet2);
    
    %Decay calculations
    
    BlackRodDecay = GetDecayTemp('BlackRodDecay.csv');
    dy = diff(BlackRodDecay(:,2))./diff(BlackRodDecay(:,1));
    x = BlackRodDecay(:, 2);
    CoeffSet3 = getCoeffSet(x(2:end)', dy', Tsurr);
    ValSet3 = CoeffSetToValSet(CoeffSet3, A1);
    [e, f] = getBestVal(ValSet3);
    
    PlainRodDecay = GetDecayTemp('PlainRodDecay.csv');
    dy = diff(PlainRodDecay(:,2))./diff(PlainRodDecay(:,1));
    x = PlainRodDecay(:,2);
    CoeffSet4 = getCoeffSet(x(2:end)', dy', Tsurr);
    ValSet4 = CoeffSetToValSet(CoeffSet4, A1);
    [g, h] = getBestVal(ValSet4);
    %}
end

function DataMatrix = GetDecayTemp(s)
    filename = s;
    fileID = fopen(filename);
    Data = textscan(fileID, '%s %s');
    fclose(fileID);
    
    timeStep = 2; %sec/measurement
    
    DataMatrix = zeros(length(Data{1}), length(Data));
    for j = 1:length(Data)
        DataCol  = Data{j};
        for i = 1:length(Data{j})
            DataMatrix(i, j) = str2double(DataCol{i});
        end
    end
    
    DataMatrix(1, 1) = 0;
    DataMatrix(:, 1) = DataMatrix(:, 1).*timeStep;
end

function ValSet = CoeffSetToValSet(CoeffSet, A)
    [r, c] = size(CoeffSet);
    ValSet = zeros(r, c);
    for i = 1:r
        [e, h] = solveForEpiAndHFromCoeff(CoeffSet(i, 1), CoeffSet(i, 2), A);
        ValSet(i, 1) = e;
        ValSet(i, 2) = h;
    end
    %disp(ValSet);
end

function CoeffSet = getCoeffSet(T, y, Tsurr)
    CoeffSet = zeros(100, 2);
    for f = 1:100
        [a, b] = getCoeff(T, y, Tsurr);
        CoeffSet(f, 1) = a;
        CoeffSet(f, 2) = b;
    end
    %disp(CoeffSet);
end

function [coeff1, coeff2] = getCoeff(T, y, Tsurr)
    
    x = T';
    y = y';
    
    ft = fittype( @(a,b,c,d,x) a*x.^4+b*x+a*c+b*d, 'problem', {'c', 'd'});
    [fitobj,~,~,~]=fit(x,y,ft, 'problem', {-(Tsurr^4), -Tsurr}); %[fitobj, goodness, output, convmsg]=fit(x,y,ft)
    coeff1=fitobj.a;
    coeff2=fitobj.b;

     yfit=coeff1*x.^4+coeff2*x-coeff1*(Tsurr^4)-coeff2*Tsurr;     %Remember dot notation
     
end

function [bestE, bestH] = getBestVal(coeffSet)
    
    whitakerH = 52.3406; %number from Cole
    
    set = coeffSet(1, :);
    bestE = set(1);
    bestH = set(2);
    for f = 1:100
        set = coeffSet(f, :);
        a = set(1);
        b = set(2);
        if (abs(whitakerH - bestH) > abs(whitakerH - b))
            %disp(bestH);
            bestE = a;
            bestH = b;
        end
    end
    %disp(bestH);
end

function [ep, h] = solveForEpiAndHFromCoeff(a, b, A)
    ep = a/(5.67*10^(-8)*A);
    h = b/A;
end

function [ANS] = elec343Lab1(number)
	%input the part number that you want
	%Table1 => number = 1
	%Table5 => number = 2
	%Table6 => number = 3
	%Search "TODO" to put in the right numbers
    
    k = getk1andk2(); %[mH*mm, mm]
    k1 = k(1);
    k2 = k(2);
    Cvn = (10^(-3))*9.81*(100/.05 + 200/.101 + 500/.23)/3; %N/V
    Ffr = .06*Cvn; %N
    
    %Pt 1
    if (number == 1)
        ANS = k;
        disp('First number is k1 (mH*mm), second number is k2 (mm)');
    end
    
    %Pt 2
    if (number == 2)
        Vapp = 10; %V TODO
        Iapp = 3; %A TODO
        x = 27:.25:31; %mm
        xInitial = 26.5; %mm TODO
        x = x - xInitial;
        Vp = [3.131 3.157 2.861 2.109 1.995 1.661 1.557 1.258 1.157 1.043 .937 .858 .799 .737 .695 .634 .597]; %V
        
        Ftotal = Vp*Cvn;
        Femes = Ftotal - Ffr; %N
        Fcalc = -k1*(Iapp^2)./(2*((k2 + x).^2)); %N
        %Fcalc = -30*k1*(Iapp^2)./(2*((k2 + x).^2)) + 175; %N
        
        figure(1)
        clf
        hold on
        plot(Femes);
        plot(Fcalc);
        
        ANS = {Femes, Fcalc};
        disp('First array is Femes (N), second array is Fcalc (N)');
    end
    
    %Pt 3
    if (number == 3)
        Vapp = 1:.5:10; %V
        Iapp = [.046 .064 .082 .1 .118 .136 .154 .171 .189 .207 .225 .242 .260 .277 .295 .312 .330 .347 .366]; %A
        Vcell = [0 .015 .071 .159 .197 .311 .421 .552 .643 .809 .862 .972 .986 1.211 1.394 1.514 1.619 1.654 1.906]; %A
        
        xPlunger = 36; %mm TODO
        xInitial = 25.5; %mm TODO
        x = xPlunger - xInitial;
        
        Ftotal = Vcell*Cvn;
        Femes = Ftotal - Ffr; %N
        Fcalc = -k1*(Iapp.^2)./(2*((k2 + x)^2)); %N
        %Fcalc = 200*k1*(Iapp.^2)./(2*((k2 + x)^2)); %N
        
        figure(1)
        clf
        hold on
        plot(Femes);
        plot(Fcalc);
        
        ANS = {Femes, Fcalc};
        disp('First array is Femes (N), second array is Fcalc (N)');
    end
end

function k = getk1andk2()
    x = [26.45 27 27.05 27.1 27.15 27.2 27.25 27.3 27.35 27.4 28 29 30 31 32 33 34 35 35.05 35.1 35.15 39.5 40]; %mm
    LmMeasure = [628.7 566.5 561 554.3 546.8 531.2 517.1 502.1 489.1 478.4 377.2 275.4 209 161.9 136.1 113.9 97.38 84.06 78.27 77.3 77.67 74.75 70.56]; %mH
    L0 = 29.66; %mH
    
    Lmeas = LmMeasure - L0; %mH
    dataSize = size(x);
    A = ones(dataSize(2), 2);
    A(:, 2) = -(Lmeas');
    B = (Lmeas.*x)';
    k = A\B; %[mH*mm, mm]
end
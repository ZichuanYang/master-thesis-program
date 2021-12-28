function [tau1,tau2,polarU1,polarU2] = plusfitting_timeconstant_2RC_d(Time,Ut)
    x = Time;
    y = Ut;
    syms t 
    ff = fittype('a-b*exp(-c*t)-d*exp(-e*t)','independent','t','coefficients',{'a','b','c','d','e'});  %fittype是自定义拟合函数
    opt=fitoptions(ff);
    opt.StartPoint=[3 0.05 0.1 0.05 0.01]; % 初始值设定很关键 影响拟合结果 建议给出期望数量级参数
    opt.Lower = [0,0,0,0,0]; %下边界
    cfun = fit(x , y , ff, opt)
    figure, plot(cfun,x,y);
    coe = coeffvalues(cfun);                 % 导出参数
    tau1 = 1/coe(3);
    tau2 = 1/coe(5);
    polarU1 = coe(2);
    polarU2 = coe(4);
    if tau1 > tau2 % 第一个RC环时间常数小，第二个大
        pp = tau2;
        tau2 = tau1;
        tau1 = pp;
        polarU1 = coe(4);
        polarU2 = coe(2);
        clear pp;
    end
end
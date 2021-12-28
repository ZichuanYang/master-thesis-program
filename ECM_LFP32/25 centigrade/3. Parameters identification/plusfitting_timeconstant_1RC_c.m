function [tau1,polarU1] = plusfitting_timeconstant_1RC_c(Time,Ut)
    x = Time;
    y = Ut;
    syms t 
    ff = fittype('a+b*exp(-c*t)','independent','t','coefficients',{'a','b','c'});  %fittype是自定义拟合函数
    opt=fitoptions(ff);
    opt.StartPoint=[3 0.05 0.1 ]; % 初始值设定很关键 影响拟合结果 建议给出期望数量级参数
    opt.Lower = [0,0,0]; %下边界
%     opt.Upper = [10,0.1,0.1,0.1,0.1]; %上边界
    cfun = fit(x , y , ff,opt);
    figure, plot(cfun,x,y);
    coe = coeffvalues(cfun);                 % 导出参数
    tau1 = 1/coe(3);
    polarU1 = coe(2);
end
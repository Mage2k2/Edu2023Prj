function dydt=tank(t,y,U,parameter)
%%��������
kp=50;      %����������ϵ��
z0=5000;    %��������ϵ��
z1=z0;
z2=z0;
z3=15000;
z1L=50000;
z3L=z1L;
g=9.8;      %�������ٶ�
row=1000;   %ˮ���ܶ�
a=1;        %�ܵ������
A=10;       %Һ�������
h4=0;       %йˮ������Һ���߶�

n=length(parameter);
leak=parameter(1);
if (n>=2)
    z3=z3/(parameter(2)+0.001)^2*50^2;
end
if (n>=3)
    z1L=z1L/(parameter(3)+0.001)^2*10^2;
    z3L=z1L;
end

%%��������ת�����ٷֱ�ת�����������̣�
u=U/100*24;
h1=y(1)/100*0.35;
h2=y(2)/100*0.35;
h3=y(3)/100*0.35;

%%��������
Q0=a*sign(kp*u*u/row-g*h1)*sqrt(2/(1+z0)*abs(kp*u*u/row-g*h1));
Q1=a*sign(h1-h2)*sqrt(2/z1*g*abs(h1-h2));
Q1L=a*sign(h1-h4)*sqrt(2/z1L*g*abs(h1-h4));
Q2=a*sign(h2-h3)*sqrt(2/z2*g*abs(h2-h3));
Q3=a*sign(h3-h4)*sqrt(2/z3*g*abs(h3-h4));
Q3L=a*sign(h3-h4)*sqrt(2/z3L*g*abs(h3-h4));

%%Һλ�仯�ʼ���
dh1=(Q0-Q1)/A;
if leak==1,
    dh1=dh1-Q1L/A;
end
dh2=(Q1-Q2)/A;
dh3=(Q2-Q3)/A;
if leak==3,
    dh3=dh3-Q3L/A;
end

%%��������ת������������ת���ɰٷֱȣ������
dydt=[dh1/0.35*100;dh2/0.35*100;dh3/0.35*100];

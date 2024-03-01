function du=PID(r,y,delta,Ti,Td)
e=r-y;

du=100/delta*(e(3)-e(2));
du=du+100/delta*(e(3)-e(2)-e(2)+e(1))*Td;
if Ti>0,
    du=du+100/delta*e(3)/Ti;
end

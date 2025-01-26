function status = NMEA(x,y,way,mN,fileDesc,N, speed,crg_time)
t = [0,0];

ang = zeros(1,N-1);
for i = 1:N-1
    a = way(i);
    b = way(i+1);
    dx = x(a)-x(b);
    dy = y(a)-y(b);
    l = dx + 1j*dy;
    ang(i) = rad2deg(angle(l));
    if(ang(i)<0)
        ang(i) = 360 + ang(i);
    end
end

for i = 1:N-1
    endsign='N';
    dist = mN(way(i),way(i+1));
    mlt = 0;
    if i>1
        mlt = 1;
    end
    t = t + [0,mlt*crg_time];
    t = toDate(t);
    if i == N-1
        endsign = 'E';
    end
    if ang(i)~=0
        fprintf(fileDesc,'"$UTHDG",%02d,%.1f,%.2f,%s,%.2f,%s\n', t(1), t(2), dist,'T', ang(i), endsign);
        fprintf('"$UTHDG",%02d,%.1f,%.2f,%s,%.2f,%s\n', t(1), t(2), dist,'T', ang(i), endsign);
    else
        fprintf(fileDesc,'"$UTHDG",%02d,%.1f,%.2f,%s,%s\n', t(1), t(2), dist,'N', endsign);
        fprintf('"$UTHDG",%02d,%.1f,%.2f,%s,%s\n', t(1), t(2), dist,'N', endsign);
    end
    t = t + [0,60*mN(way(i),way(i+1))/speed];
    t = toDate(t);
end
end

function a = toDate(t)
a = t;
a(1) = a(1) + floor(a(2)/60.0);
a(2) = mod(a(2),60);
end


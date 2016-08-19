sys = tf(10, [1, 1, 0]);

%ezplot('100*exp((-ksi*pi)/sqrt(1-ksi^2))',[0 1])
%ylabel('MO [%]'), xlabel('\xi')

tlumienie = 0.403;

%ezplot('atand(2*x/sqrt(sqrt(1+4*x^2)-2*x^2))',[0.35 0.45])
%ylabel('PM'), xlabel('\xi')

pm_komp = 39.4478; % zapas fazy jak¹ uk³ad ma mieæ po kompensacji

% zapas fazy bez kompensacji
[gm, pm_bez_komp, wgm, wpm] = margin(sys);

% zapas fazy, któr¹ ma wnieœæ do uk³adu kompensator
q = pm_komp - pm_bez_komp; 

% parametry tego kompensatora
a = (1+sind(q))/(1-sind(q));

aa = (1-sind(q))/(1+sind(q));

% czêstotliwoœæ wm
wm = 3.77; %[rad/s]
% T
T = 1/(wm*sqrt(a));

%kompensator
%kompensator = tf([a*T,1],[T,1]);
kompensator = tf([1, 1/T],[aa, 1/T]);
otwarty = series(kompensator, sys);
zamkniety = feedback(otwarty, 1);
figure(1);
step(zamkniety);
grid on;
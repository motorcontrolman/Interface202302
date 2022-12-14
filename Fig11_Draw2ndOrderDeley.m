s = tf('s');
K = 10;
wn = 10 * 2 * pi;

zeta = [0, 0.25, 0.5, 1, 1.5];

Freq = logspace(-2, 3, 1000).';
w = 2 * pi * Freq;

tiledlayout('flow');

nexttile(1); 
axis([0.1, 1000, -60, 60]);
xlabel("周波数[Hz]");
ylabel("ゲイン[dB]");

nexttile(2); 
xlabel("周波数[Hz]");
ylabel("位相[°]");

legendTxt = [];

for i = 1:length(zeta)
    Gs = K * wn^2 / (s^2 + 2*zeta(i)*wn*s + wn^2);
    [Mag, Phase] = bode(Gs, w);                 % ゲイン、位相の算出
    Gain = 20 * log10( reshape(Mag, [], 1) );   % ゲインデータ成形および単位変換
    Phase = reshape(Phase, [], 1);              % 位相データの成形

    legendTxt = [legendTxt; ...
    "\zeta = " + num2str(zeta(i))];

    nexttile(1);
    slg = semilogx(Freq, Gain);
    hold on; grid on;
    slg.LineWidth = 2;

    nexttile(2);
    slp = semilogx(Freq, Phase);
    hold on; grid on;
    slp.LineWidth = 2;

end

nexttile(1);
axis([0.1, 1000, -60, 60]);
legend(legendTxt);
xlabel("周波数[Hz]");
ylabel("ゲイン[dB]");

nexttile(2);
axis([0.1, 1000, -180, 0]);
yticks(-180: 45: 0);
legend(legendTxt);
xlabel("周波数[Hz]");
ylabel("位相[°]");

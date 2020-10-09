// Pwhite(x,y) generates random numbers between x and y
(
Pbind(
	\freq, Pwhite(1000,1500),
\dur, 0.02,
\amp, 0.2,
\legato, 1
).trace.play;
)
s.boot

(
x = Array.exprand(8, 200, 1000).round(100);
x = x.sort; // sort the array
x.do({
	arg n, i;
	var amp;
	amp = 1/(i+1); //reciprocal, +1 *
	amp = amp * 0.2;
	amp.postln;
	{
		var sig;
		sig = SinOsc.ar(n);
		sig = sig * amp;
		sig!2;
	}.play;
});
)
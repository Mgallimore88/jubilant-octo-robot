(
{
	var sig, amp, cutoff;
	amp = EnvGen.kr(Env.new(
		[0.8,0],
		[0.3],
		[\lin]), doneAction:2);
	cutoff = EnvGen.kr(Env.new(
		[10000, 10],
		[0.3],
		[\exp]
	));
	sig = Saw.ar([50, 60, 90]);
	sig = LPF.ar(sig, cutoff);
	sig = (sig * amp)!2;
}.play
)
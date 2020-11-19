(
x = {
	var sig, env, frequency;
	env = EnvGen.kr(
		Env.new(
			[0, 1, 0],
			[1, 3],
			[0, 0]
		),
		doneAction:2
	);
	sig = Saw.ar(80);
	sig = LPF.ar(sig, 1590);
	sig = sig * env;
	sig = sig!2;
}.play
)

Env.perc(0.01, 1.0).plot;
Env.triangle(1.0).plot;

Env.adsr(0.01, 0.3, 0.5, 1.0).plot;
// adsr envelopes are different to the others. the first two arguments are time, then the third is sustain level, and the fourth is release time. The sustain level will be held until the gate threshold is crossed. Therefore we need to specify a gate threshold and pass the gate value in as an argument.

(
f = {
	arg gate=1;
	var sig, env;
	env = EnvGen.kr(
		Env.adsr(0.01, 0.3, 0.5, 1.0),
		gate,
		doneAction:2
	);
	sig = Saw.ar(80);
	sig = LPF.ar(sig, 1590);
	sig = sig * env;
	sig = sig!2;
}
)

x = f.play(args:[\gate, 0])
x.set(\gate, 1)
x.set(\gate, 0)

// if we want to retrgger the envelope multiple times we can ignore doneAction:2 OR set doneAction:0



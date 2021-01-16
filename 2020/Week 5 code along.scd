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

(
f = {
	arg t_gate=1;
	var sig, env;
	env = EnvGen.kr(
		Env.perc(0.01, 1.0),
		t_gate,
		doneAction:0
	);
	sig = Saw.ar(80);
	sig = LPF.ar(sig, 1590);
	sig = sig * env;
	sig = sig!2;
}
)

x = f.play(args:[\t_gate, 0])
x.set(\t_gate, 1)

// In the above example, we rename the gate with t_gate. any arguments which start with t_  are called TRIGGER CONTROL arguments. If they are set to a positive value they will output that value for one control cycle before returning to zero. In this way they can be used as triggers for sound events, without having to manually set the gate argument to zero then back to one again. We have removed the doneAction:2 command otherwise the synth disappears from the server once the envelope is complete.




////////////////////////////MULTICHANNEL//////////////////////

s.options.numOutputBusChannels = 8;
s.reboot;

s.scope

///////////

// Multichannel expansion propogates through the expression graph - this means that a stereo signal which is modified by future expressions would yield the same outputs as two paralle mono signals. Expressions further down the chain are converted into arrays of generators rather than single generators, and the entire multichannel array is processed in parallel.


// ctrl+m to show mixer

(
x = {
	var sig, freqs;
	freqs = Array.series(8, 150, 150);
	sig = SinOsc.ar(freqs, 0 , [0.4, 0.05]);

}.play

)

// in this example a harmonic series 8 long is given an array of amplitudes 2 long. the amplitudes as the shorter array will wrap around.


// we still can't hear the remaining 6 harnmonics. To bounce multi channel audio down to mono, one technique is to use the .sum method on the signal. Since the multichannel signal is just a array of numbers.

[1,2,3,4].sum
// here we have a 30 channel signal bounced to mono then up to stereo
(
x = {
	var sig, freqs;
	freqs = Array.exprand(30, 150.0, 250.0);
	sig = SinOsc.ar(freqs, 0 , 0.01);
	sig = sig.sum;
	sig = sig!2

}.play

)

//////
// remember how collect works:
y = [1,2,3,4,5].collect{arg n; n.squared};


(
x = {
	var sig, freqs;
	freqs = Array.exprand(3, 150.0, 2500.0);
	sig = SinOsc.ar(freqs, 0 , 0.01);
	sig.collect({
		arg n;
		Pan2.ar(n, rrand(-1.0, 1.0))
	});
	sig = sig.sum;
}.play
)

// each of the frequencies is panned left or right by a random amount


(
x = {
	var sig, freqs;
	freqs = Array.exprand(3, 1500.0, 4000.0);
	sig = SinOsc.ar(freqs, 0 , 0.01);
	sig = Splay.ar(sig);
}.play
)

// Splay will equally space an array of signals over the stereo field.

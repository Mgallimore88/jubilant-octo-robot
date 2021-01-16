s.boot;

(
	f = {
		arg freq=100;
		var sig;
		sig = Pulse.ar(freq * [1, 1.01], 0.5, 0.04);
		sig = sig + SinOsc.ar(freq * 1.5 * [1.0, 1,004], 0, 0.15);
		sig = sig + BrownNoise.ar(0.04!2);
		sig = sig * Line.ar(0,1, 10);
	};

)


x = f.play(args:[\freq, 450])
x.set(\freq, 120) // updates whilst playing
x.set(\gate, 0, \fadeTime, 5);

/////////////  CONVERT ALL OF THE ABOVE INTO A SYNTHDEF ///////////

// f.play is a shortcut to making a synthdef. It adds an envelope and specifies an output bus, amongst other things.

// To make a SynthDef, the name is a string "" or symbol \name
// The ugenGraphFunc is the function which contains all the ugens - the thing we would have applied .play to
// We need to specify an output bus at the end of the synthDef
// finally .add adds the new synthdef
(
SynthDef.new(\ocean,
	{
		arg freq=100;
		var sig;
		sig = Pulse.ar(freq * [1, 1.01], 0.5, 0.04);
		sig = sig + SinOsc.ar(freq * 1.5 * [1.0, 1,004], 0, 0.15);
		sig = sig + BrownNoise.ar(0.04!2);
		sig = sig * Line.ar(0,1, 10);
		Out.ar(0, sig);
	}).add;
)

// To play the synth,

x = Synth.new(\ocean);
x.free;

x = Synth.new(\ocean, [\freq, 350]);
x.set(\freq, 250);
x.set(\gate, 0, \fadeTime, 5); // currently this doesn't work!
x.free;

// Another thing f.play adds is an envelope - this stops the sound from clicking when starting, and adds a gate for fadeTime to act on.

//Here's the same SynthDef with an envelope added:

(
SynthDef.new(\ocean,
	{
		arg freq=100, gate=1, atk=3, rel=3, pan= 0, out=0;
		var sig, env;
		env = EnvGen.kr(
			Env.asr(atk, 1, rel, [1,-1]),
			gate,
			doneAction:2
		);
		sig = Pulse.ar(freq, 0.5, 0.04);
		sig = sig + SinOsc.ar(freq * 1.5, 0, 0.15);
		sig = sig + BrownNoise.ar(0.04);
		sig = sig * env;
		sig = Pan2.ar(sig, pan);
		Out.ar(0, sig); // always provide a single integer to out, not an array - otherwise subsequent array items get sent to subsequent buses and this can cause unexpected results:L=0, R=1 + L=1 R=2
	}).add;
)

// To play the synth,
s.meter
x = Synth.new(\ocean, [\pan, 1]);
x.set(\pan, -1);
x.free;

a = [];
a = a.add(Synth(\ocean, [\pan, -1]));
a = a.add(Synth(\ocean, [\freq, 150, \pan, 1]));
a = a.add(Synth(\ocean, [\freq, 240, \pan, 0.7]));

a.do({arg synth; synth.set(\gate, 0)});
// Now the sound stops after release time. We have also added variables for the output bus number. If a stereo signal is sent to Pan2 then each signal will be combined and the output will be mono.



/////////// ROUTINES ////////////
// a type of function which can be played, including wait times

(
r = Routine.new({
	"hello".postln;
	wait(2);
	"how are you?".postln;
})
)

r.play
// after playing, routines stay at the end.
r.reset;
r.next

r.stop

Synth(\ocean, [\freq, 60.midicps, \pan, rrand(-0.5, 0.5)]);


(
r = (
Routine.new({
	Synth(\ocean, [\freq, 69.midicps, \pan, rrand(-0.5, 0.5)]);
	wait(3);
	Synth(\ocean, [\freq, 62.midicps, \pan, rrand(-0.5, 0.5)]);
	4.wait;
	Synth(\ocean, [\freq, 67.midicps, \pan, rrand(-0.5, 0.5)]);
})
)
)

(
r.reset; r.play;
)
r.stop;






// same as other synthdef but has a short envelope and no gate
(
SynthDef.new(\ocean,
	{
		arg freq=100, gate=1, atk=0.01, rel=1, pan= 0, out=0;
		var sig, env;
		env = EnvGen.kr(
			Env.new(
				[0, 1, 0],
				[atk, rel],
				[0,4]
			),
			doneAction:2
		);
		sig = Pulse.ar(freq, 0.5, 0.04);
		sig = sig + SinOsc.ar(freq * 1.5, 0, 0.15);
		sig = sig + BrownNoise.ar(0.04);
		sig = sig * env;
		sig = Pan2.ar(sig, pan);
		Out.ar(0, sig);
	}).add;
)


(
r = Routine.new({
	inf.do{
		Synth(\ocean, [\freq, exprand(67, 43).midicps, \pan, rrand(-0.5, 0.5)]);
		wait(0.2); // calling inf.do, we MUST use a wait command otherwise we're asking the processer to perform an infinite number of ops simultaneously.
	}

})
)

(
r = Routine.new({
	3.do{
		Synth(\ocean, [\freq, exprand(67, 43).midicps, \pan, rrand(-0.5, 0.5)]);
		wait(0.2);
	}

})
)

(
r = Routine.new({
	3.do{
		Synth(\ocean, [\freq, exprand(67, 43).midicps, \pan, rrand(-0.5, 0.5)]);
		wait(0.2);
	}

})
)


r.play
r.reset

(
r = Routine.new({
	{
		Synth(\ocean, [\freq, exprand(67, 43).midicps, \pan, rrand(-0.5, 0.5)]);
		wait(0.2);
	}.loop // loop causes a routine to repeat - similar to inf.do
})
)

r.play
r.stop
r.reset

(
r = {
	{
		Synth(\ocean, [\freq, exprand(67, 43).midicps, \pan, rrand(-0.5, 0.5)]);
		wait(0.2);
	}.loop;
}.fork; // forking a function means we don't have to specify a new Routine

)
)


// cannot use wait outside of a routine - this is why we need routines.

// possible to nest routines to create periodic behaviour





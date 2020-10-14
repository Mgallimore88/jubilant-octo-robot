s.boot;


// SOFTCLIP reduces distortion when clipping

// Pan2 provides a power compensated pan of the signal from left to right so that the sound is the same volume across all positions. second arg is pan, third is mul.
(
f = {
 var sig;
	sig = SinOsc.ar(220);
	sig = sig * 8;
	sig = sig.softclip;
	sig = Pan2.ar(sig, 0, 0.2);
};
)

x = f.play;
x.free


// setting the value of arguments after the function is defined:

(
f = {
	arg freq = 330, boost = 4;
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * boost;
	sig = sig.softclip;
	sig = Pan2.ar(sig, 0, 0.2);
};
)

x = f.play;
x.set(\freq, 200);
x.set(\freq, exprand(50, 800));
x.set(\boost, 1);
x.release(1); // 1s slow release
x.free;

// passing arguments to play:
x = f.play(args:[\freq, 220]);

// using MIDINOTES  -cycles per second
60.midicps // 60 is middle c
108.midicps // highest note on piano


x.set(\freq, 30.midicps);
x.set(\freq, (55, 57..79).midicps.choose);


x = f.play(args: [\freq, (40, 43..70).midicps.choose])

x.release(3); // this will not release multiple instances of x. for multiple instances of x, use arrays.


// How to release multiple synths:
a = [];
a = a.add(f.play(args: [\freq, (40, 45..90).midicps.choose]))

a.do({arg n; n.release(1)});


// instead of hitting return 12 times to initialise notes, we can use 12.do.
// since we released the synths from the server we should clean them up on the client side too using a = []

(
a = [];
12.do({
a = a.add(
		f.play(args: [\freq, (40, 42..50).midicps.choose]))
})
)

a.do({arg n; n.release(exprand(12,1,3))});




// adding more arguments:
// pan and amp added to synth def

(
f = {
	arg freq=330, boost=4, pan=0, amp=0.1;
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * boost;
	sig = sig.softclip;
	sig = Pan2.ar(sig, pan, amp);
};
)

// varied values of freq, pan and amp added to notes. fadeTime adds an attack value
(
a = [];
12.do({
a = a.add(
		f.play(
			fadeTime:exprand(3,6),
			args: [
			\freq, (40,46..100).midicps.choose,
			\boost, exprand(1, 8),
			\pan, rrand(-0.8, 0.8),
			\amp, exprand(0.04, 0.1)]);
	)
})
)

// slow release
a.do({arg n; n.release(exprand(12,1,3))});




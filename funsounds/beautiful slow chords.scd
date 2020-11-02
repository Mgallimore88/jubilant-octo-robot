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
				\freq, ((50,57..72).choose - [0, 2].choose).midicps,
			\boost, exprand(1, 8),
			\pan, rrand(-0.8, 0.8),
			\amp, exprand(0.04, 0.1)]);
	)
})
)

// slow release
a.do({arg n; n.release(exprand(12,1,3))});


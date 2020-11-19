


(
x = {
	var sig, amp;
	amp = EnvGen.kr(Env.new(
	[0,1,0,1,0,1,0],
	[0.1, 1.9, 1, 1, 1.9, 0.1],
	[0, -8, -8, 8, 8, 0];
	));
	sig = PinkNoise.ar(1!2);
	sig = BPF.ar(sig, amp*80, 0.02, amp);
}.play
)
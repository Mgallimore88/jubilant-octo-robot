
Server.local.boot;
(
z = {
	arg freq = 511.359, amp = 1;
	var sig;
	sig = SinOsc.ar(freq, 0, amp, 0);
}.play;
)
z.set( \amp, 0.4);
z.set(\amp 0.5, \freq 888);
z.free






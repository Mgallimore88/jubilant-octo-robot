/* Methods such as Function-play, etc. are simply conveniences which automatically create such a def. Function.play is often more convenient than SynthDef.play, particularly for short examples and quick testing. The latter does have some additional options, such as lagtimes for controls, etc. Where reuse and maximum flexibility are of greater importance, SynthDef and its various methods are usually the better choice.

*/

(
z = {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(100).range(0.02,1);
	sig = SinOsc.ar(freq) * amp;
}.play
)
z.set( \noiseHz, 2);
// for strings use \string or "string"
z.free;

/* the difference between making a synthdef and calling play on a function is shown below - the code below does the same as the code above. the difference is line 1 SynthDef.new("string", {function})
line 7 Out.ar.(0,sig);
line 8 }.add
line 10. Finally we need to execute the synth.
*/
(
SynthDef.new(\sineTest, {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(10).range(0.02,1);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig);
}).add;
)
x= Synth.new(\sineTest);
x.free

//pulseTest

(
SynthDef.new("pulseTest", {
	arg ampHz = 4, fund = 40, max_partial = 4, width = 0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz, 0.5, 0.12) * 0.75;
	freq1 = LFNoise1.kr(10).exprange(fund, fund * max_partial).round(fund);
	freq2 = LFNoise1.kr(10).exprange(fund, fund * max_partial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1); //octave
	freq2 = freq2 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add
)
x = Synth.new(\pulseTest);
y = Synth.new(\pulseTest);
z = Synth.new(\pulseTest);
x.set(\fund, 100, \ampHz, 2, \max_partial, 8, \width, 0.5);
y.set(\fund, 60, \ampHz, 4, \max_partial, 2, \width, 0.5);
z.set(\fund, 80, \ampHz, 1, \max_partial,3, \width, 0.1);

x.free
y.free;
z.free;
s.scope

//the .round(fund) will round to the nearest multiple of the fundamental frequency, giving random overtones of this freq

// LFNoise0.kr(8, add:1); adds octave jumps. LFnoise0 normally ranges from 0 to 1so adding 1 ranges from 1 to 2

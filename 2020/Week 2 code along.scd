Server.local.boot;


// change 1000

s.quit;

s.makeWindow;


// shows levels on 2 input drivers and 2 output drivers.
s.meter;

s.scope;

//frequency analysis
FreqScope.new;

s.plotTree;


//sinosc is a class. need to call a method of the class. sinosc on its own won't be playable
{ SinOsc.ar }.play;

// ar creates 44.1k samples per seconds. sample period can be changed to suit needs. kr uses less samples per second.

~sine = { SinOsc.ar }.play;
~saw = { Saw.ar }.play;
~sine.free;
~saw.free;

// so far all these are mono in the left ear. For 2 channel :

//the interpreter assumes arrays of ugens are multi channel, starting with left and right.

~stereosin = { [SinOsc.ar, SinOsc.ar] }.play;

// Shortcut for this: we can use the y.dup(x) method to duplicate y x times:

~stereosin = { SinOsc.ar.dup(2) }.play

//even quicker is the shorthand
// x!y

5.dup(4);
5!4;

//so !2 is quick shorthand to make a mono signal stereo.

// SINOSC ARGS //

// SinOsc.ar(freq, phase, multiply, add)

~sine ={ SinOsc.ar(300,pi/2, 0.8, 0) }.plot;

// use positional defs or explicitly specify the name to change the order of args using freq:arg syntax

~sine ={ SinOsc.ar(300, add:2) }.plot;


// multiple channels at the same time can ve added. The two methods below are the same effect implemented in two different styles.

(
~sum = {
	var sig;
	sig = SinOsc.ar(mul:0.2);
	sig = sig + SinOsc.ar(500, mul:0.3);
}.play;
)

(
~sum = {
	var sig1, sig2, sig3;
	sig1 = SinOsc.ar(mul:0.2);
	sig2 = SinOsc.ar(500, mul:0.3);
	sig3 = SinOsc.ar(700, mul:0.3);
	sig1 + sig2 + sig3;
}.play;
)

// VIBRATO //

(
~vib ={
	var sig, vib;
	vib = SinOsc.kr(6, 0, 20, 300);
	sig = SinOsc.ar(vib, mul:0.2)!2;
}.play
)

// simpler than passinng mul and add to sinosc is to use
// sinosc(freq).range(min,max)
// to set the frequency of the variation.range(200, 300). range maps a range to between specific values.

(
~vib ={
	var sig, vib;
	vib = SinOsc.kr(6).range(500,700);


	sig = SinOsc.ar(vib, mul:0.2)!2;
}.play;
)

s.makeWindow
// the last line to get evaluated gets returned


(
~alarm = {
	var mod, sig;
	mod = LFSaw.ar(0.5).range(0, 500);
	sig = Pulse.ar(300 + mod, 0.5, 0.1);
}.play;
)
~alarm.free;


// mul can be replaced by a straight division, and lines can be split for readability:


(
x = {
	var sig;// define local variable
	sig = SinOsc.ar; // make a SinOsc UGen at audio rate with defaults
	sig = sig * 0.2; // multiply each sample by 0.2
	sig = sig!2; // shortcut for .dup(2) or [sig, sig]
}.play;
)

// the above code is readable, verbose, and is the same as
// the below code which is more compact but less readable.

(
x = {
	var sig;
	sig = SinOsc.ar*0.2!2;
}.play;
)

// BINAURAL BEATS OR 2 CHANNEL SIN OSC

(
x = {
	SinOsc.ar([500, 501], 0,0.1)
}
)
x.play;
(
y = {
	SinOsc.ar([100, 103], 0,0.1)
}
)
y.play;

(
z = {
	SinOsc.ar([130, 133], 0,0.1)
}
)
z.play;


//UGEN LIST

// Oscilltors: band limited (antialiasing)

SinOsc, Saw, Pulse, Blip

// oscillators: non-band-limited:
// (optimal for low freq-will alias at high freq)

LFSaw, LFPulse, LFTri, VarSaw

// Noise Generators:
WhiteNoise, PinkNoise, LFNoise0, LFNoise1

//filters: low/high pass (R=Resonant). low/high shelf, band pass/reject
LPF, HPF, RLPF, RHPF, BLowShelf, BHiShelf, BPF, BRF (also BEQSuite)

//triggers
Impulse, Dust, Trig


//envelopes
Line, XLine, EnvGen

// sample playback
PlayBuf, BufRd

// delays
DelayN, DelayL, DelayC //no feedback

CombN, CombL, CombC // with feedback

// stereo panners/ balancers
Pan2, Balance2
















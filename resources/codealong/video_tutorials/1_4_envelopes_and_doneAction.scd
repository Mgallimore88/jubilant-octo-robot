Server.local.boot;
s.scope;
Server.local.plotTree; // shows what the server is running. unfr
s.quit

{SinOsc.ar(1000)}.play



x = {PinkNoise.ar * 0.5}.play
// sound will start and stop instantaneously.
x.free

//use envelopes
// >> Browse - UGens >> envelopes
// Line is an enveloe with start, end and duration args. also has a doneAction arg.
(
x = {
	var sig, env;
	env = Line.kr(0.5,0,2, doneAction: 2); // doneAction: 2 frees the synth associated with this env
	sig = Pulse.ar(ExpRand.new
		(500, 2000)) * env;
}.play;
)
x.free

// XLine

(
x = {
	var sig, env;
	env = XLine.kr(1,0.01,2, doneAction: 2); // XLine makes exponential curve - more natural.
	sig = Pulse.ar(ExpRand.new
		(500, 2000)) * env;
}.play;
)
x.free

//decibels
(
x = {
	var sig, env;
	env = Line.kr(0, -40, 2, doneAction: 2);
	sig = Pulse.ar(ExpRand.new
		(500, 2000)) * env.dbamp; //  dbamp converts db to amp. use when your values are in dB
}.play;
)
x.free
0.5.ampdb // converts amplitude  to dB

// XLine controlling frequency
(
x = {
	var sig, env, freq;
	env = Line.kr(-1, -40, 5, doneAction: 2); // set zero cuts sound off prematurely
	freq = XLine.kr(100, 200, 1, doneAction: 0); // set zero trails a 200Hz note
	sig = Pulse.ar(freq	) * env.dbamp;
}.play;
)
x.free





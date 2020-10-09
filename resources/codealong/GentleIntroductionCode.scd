{SinOsc.ar}.play;


//make a master volume slider
s.volume.gui

{SinOsc.ar(LFNoise0.kr(10).range(500, 1500), mul: 0.1)}.play;


{RLPF.ar(Dust.ar([100,500]), LFNoise1.ar([0.3, 0.2]).range(10, 6000), 0.02)}.play;

100.do({"Print this line over and over...".scramble.postln});

rrand(10,20);

// comments preceded by slashes

/* or contained in asterslashes */


// anything with .postln or any last line is posted to the post window. other things are skipped
"firstline".postln;
4+6;
"lastline".postln;


// RECORDING

s.record;

{Saw.ar(LFNoise0.kr([2,3]).range(100,2000), LFPulse.kr([4,5]) * 0.1)}.play;

s.stopRecording;

//optional gui:
s.makeWindow;


// Variables - preset ones a-z with s reserved for server.local
x = 10;
y = 150;
x;
y;
x-y;
y-x;
x=x+y;

// other variables need to be defined with var, and even then only exist while their code chunk is being exexuted. For persistent environment variables use a twiddle

(
var variablename = 6;
variablename;
)
// both these examples are ok. The above type is a local variable. The below type is an environment variable.
~variableName = 6;
~variableName;

variableName = 6;
variableName;
// but this is not.



// all variables can be acted on just like their contents.

a = "hello";
a.scramble;

// These (a-z) are interpreter variables;

b = Pbind(\note, Pwhite(1,5), \dur, 0.1);
b.play

c = 1;
c = c + 2;


// list of integers stored in an environment variable
~myFreqs = [415, 220, 440, 880, 220, 990];

~myDurs = [0.1, 0.2, 0.2, 0.2, 0.2, 0.1];

Pbind(\freq, Pseq(~myFreqs), \dur, Pseq(~myDurs)).play;



// PATTERNS //

Pbind(\degree, Pseries(-5, 1.5, 16), \dur, 0.1).play;


// this function plays the middle c once per second.
Pbind(\degree, 0).play;

// play with the dur:
Pbind(\degree, 3, \dur, 1).play;

// we can also pass in a sequence instead of an integer for degree, using Pseq([list of ints], num of repeats)

Pbind(\degree, Pseq([0, 9, 7, 5, 3, 1, -1,-3],4), \dur, 0.2).play;

(
Pbind(
	\note, Pseq([0, 9, 1, 7, 2, 6, 4, 5, 1], 5),
	\dur, Pseq([0.2, 0.2, 0.3, 0.1, 0.5],inf)).play;
)

(
Pbind(
	\degree, Pseq([0, 1, 2, 3, 4, 5, 4, 6, 7, 8, 9], 5),
	\dur, Pseq([0.3, 0.1, 0.3, 0.1], inf)).play;
)

//PITCH DEFINITIONS//

// \degree notes in cmaj
// \note notes in chromatic
// \midinote middle c is 60
// \freq specify Hz



// AMP AND LEGATO \\
(
Pbind(
	\degree,Pseq([7, 1, 5, 4, 2, 1], 4),
	\dur, Pseq([0.2, 0.2, 0.1, 0.1, 0.2, 0.2], 4),
	\amp, Pseq([0.8, 0.8, 0.5, 0.5, 0.3, 0.1],inf),
	\legato, 0.010).play;
)


// Prand \\ is like Pseq but instead of picking items from the pattern sequentially, it picks them randomly

(
Pbind(
	\degree,Pseq([7, 1, 5, 4, 2, 1], inf),
	\dur, Pseq([0.2, 0.2, 0.1, 0.1, 0.2, 0.2], inf),
	\amp, Prand([0.8, 0.8, 0.5, 0.5, 0.3, 0.1],inf),
	\legato, 0.010).play;
)

(
Pbind(
	\degree, Pseq([2, 3, 4, 5, 6].reverse -3, inf),
\dur, 0.6,
\amp, 0.2,
\legato, 0.1
).play;
)


// Pwhite(x,y) generates random numbers between x and y
(
Pbind(
	\freq, Pwhite(1000,1500),
\dur, 0.02,
\amp, 0.2,
\legato, 1
).trace.play;
)


// Pwhite
(
Pbind(
\note, Pseq([0, 2, 3, 5, 7, 8, 11, 12], 4),
\dur, Pwhite(0.15, 0.5);
).play;)


// Pser
(
Pbind(
\note, Pslide([0, 2, 3, 5, 7, 8, 11, 12], 9, 3, 1),
\dur, 0.15;
).play;
)

(
Pbind(
\degree, Pseries(2,-2, 10),
\dur, 0.15;
).play;
)


(
Pbind(
	\note, Pseq([0, 2, 3, 5, 7, 8, 11, 12], 8),
	\dur, Pgeom(1, 0.9, inf)
).play;
)


(
Pbind(
	\note, Pseq([0,Pn(2,3), 2, 3, 5, 7, 8, 11,Pn(16,5), 12], 8),
	\dur, 0.2
).play;
)



// CHORDS \\
(
Pbind(
	\degree, Pseq([[1,3,5,7,9], [3,5,7,9,11]],2),
	\dur, 0.8,
	\legato, 0.3,
	\strum, 0.02
).play;
)


// SCALES \\

Scale.directory;

(
Pbind(
	\scale, Scale.rast,
	\degree, Pseq([1,2,3,4,5, 5.1,6,7,8,9,10,11,12]),
	\ctranspose, -12,
	\dur, 0.3,
	\legato, 0.9,
	\strum, 0.2
).play;
)

// ctranspose is chromatic transpostiion. 5.1 picks the chromatic note one step above 5 in the scale

Pbind(\note, Pseq([0, 0.5, 1, 1.5, 1.75, 2], 1)).play;







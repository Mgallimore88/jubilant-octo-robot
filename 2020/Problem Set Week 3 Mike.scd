//Problem Set Week 3
//Due 3pm CDT Sept 17th

//First, save this scd file as a new file, renaming it with your Last name at the beginning of the file name (e.g. "Fieldsteel Problem Set Week 3.scd"), and upload this renamed file to the course website for your submission.

//As you complete this assignment, be mindful of ***ear safety***. Before running code that produces sound, turn your system volume nearly or completely all the way down, remove headphones, and monitor the visual level on the output meters (evaluate s.meter). Then, slowly turn up your system volume.


//Problem 1
//Generate an array of 16 random integers between 100 and 2000. Use an exponential distribution, so that the values tend toward the lower end of this range.


x = {exprand(100, 2000)}!(16);
x
{exprand(100, 2000)}.dup(16);


// improvements after seeing Ed's code:

{exprand(100, 2000).asInteger}!(16)

//Problem 2
//Generate an array containing 16 random odd integers between 100 and 2000. Use a linear distribution, so that the values are equally distributed across this range.

(
var test = 3;
test;
)


//odd number generator, not quite finished - lookup recursive functions.
(
var odd, x;
{
x = rrand(100, 2000).postln;
if (x.odd,
	{odd = x},
	{x = rrand(100, 2000)}
)}.value
)


// ODD NUMBER GENERATOR attempt 2 - working :

(
var odd, x;
~oddnum = {
x = rrand(100, 2000).postln;
if (x.odd,
	{odd= x},
	~oddnum; // if the number is odd, store it in x, else call the function again until it is odd
)}
)

x = Array.fill(16, ~oddnum);

// more elegant solution from Ed:
Array.fill(16, {(101, 103..1999).choose})
// putting choose inside the function gets a new value from the array each time.

(1, 3..10) // is a neat way of specifying the start, step and endpoint of an array.


//Problem 3
//Generate an array containing 16 random integer multiples of 50 between 100 and 2000. Use an exponential distribution. Also, use a global variable to store the array.
(
~expFifties = {
var fifties = Array.series(39, 100, 50);
var expindexes = {Array.fill(16, {exprand(1,17).round -1})}.value;

expindexes.collect({
	|n|
	n.postln;
	fifties[n];})
}.value
)
~expFifties

// ed's solution:
(
a = Array.fill(16,
	{exprand(100,2000).round(50).asInteger});
)
// the 'round(50)' is one part I was missing.



//Problem 4
//Using the global variable from the previous problem, write some code that adds to the array four more multiples of 50 between 2000 and 3000. Use a linear distribution. The same global variable should now store this new, larger array.

~expFifties

~expFifties = ~expFifties ++ (4.collect({20.rand() * 50 + 2050}))
// my solution uses collect instead of do, and appends scaled random numbers to the end of an array

// Ed's solution:
(
4.do({
	~expFifties = ~expFifties.add(rrand(2000,3000).round(50));
});
)
~expFifties

//Problem 5
//Write some code that plots a graph of the contents of the new, larger array that you created in the previous problem. Arrays respond to the "plot" method. (no need to overthink this problem.)

~expFifties.sort
~expFifties.plot



//Problem 6
//Use the "series" method to generate an array of numbers that represent frequencies of the first 12 harmonics of the overtone series, with a fundamental starting at 350 Hz (include the fundamental, 12 frequencies total).
(
~overtones = {
	var f, a;
	f = 350;
	a = Array.series(12, 1, 1);
	a.postln;
	a.collect
	({
		|n, index|
		a[index] * f;
	});
}.value;
)

~overtones

// Ed's solution:
Array.series(12, 350, 350);




//Problem 7
//Use the "geom" method to generate an array of 8 numbers that represent signal amplitude. The first value should be 1, and each subsequent number should be equal to half the previous number.


(
~amplitudes = {
	    var init;
		init = 1;
	(1!8).collect({

		init = init / 2;
	})
}.value
)

~amplitudes

// Ed's
Array.geom(8, 1, 0.5);

//Problem 8
//Use one or more iteration methods (do, collect, select, reject, etc.) to return an integer corresponding to the number of multiples of 100 that are contained in the array of 20 values (stored in your global variable from Problem 4).


(
~expFifties.select({
	|x, index|
	(x % 100) == 0
})
)

// Ed's
~expFifties.select({ arg n; (n % 100) == 0 }).size;
// or
(
~expFifties.collect({ arg n; if(n%100 == 0, {1}, {0})
}).sum;
)

//before continuing, boot the audio server:
Server.local.boot;

//Problem 9
//Consider the following UGen function, which produces a 2-channel sine wave with a frequency of 300 Hz and amplitude of 0.1. Use iteration to play this function five times, such that each instance has a random frequency between 200 and 1000 (exponential distribution).

(
x = {
	var sig, freq = exprand(200, 1000);
	sig = SinOsc.ar(freq);
	sig = sig * 0.1;
	sig!2;
};
)
(0!5).do({x.play})

// Ed's solution populates the array earlier in the function:
(
Array.exprand(5, 200, 1000).do({
	arg n;
	{
		var sig;
		sig = SinOsc.ar(n);
		sig = sig * 0.1;
		sig!2;
	}.play;
});
)


//Problem 10
//Once again, consider the same UGen function. This time, use your global variable that holds the array of 20 values. Iterate over your array, using the values within as frequency values for SinOsc.


(
x = {
	arg freq = 400;
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * 0.1;
	sig!2;
};
)

// to pass in an argument, define it as an argument in the parent function, then it will be accessible in the child function.

***IMPORTANT***
//Note that the amplitude has been intentionally lowered from 0.1 to 0.02, because 20 summed waveforms is louder than 5! Be mindful of ear safety!

(
~expFifties.do({
	arg freq, i;
	{
	var sig;
	sig = SinOsc.ar(freq);
	sig = sig * 0.5 * (0.75.pow(i));
	sig!2;
	}.play;
});
)


// Ed's solution:

// declare a local variable:
var amp;

// which holds an array containing the amplitude modifiers:
~amp = Array.geom(~expFifties.size, 0.1, 0.75).sort;


(
~expFifties.do({
	arg freq, i;
	{
	var sig;
	sig = SinOsc.ar(freq);
		sig = sig * ~amp.at(i);
	sig!2;
	}.play;
});
)



//Problem 11
/*
Modify your work from the previous problem, making the following changes:

- the frequency array should be sorted from low to high

- the amplitude of the 0th SinOsc should be 0.1

- the amplitude of each subsequent SinOsc should be
0.75 times as loud as the previous one (hint: declare
a second argument in your iteration function so you can
access the iteration count)
*/

//The result should be a more "bass-heavy" timbre.

(
~expFifties.do({
	arg freq, i;
	{
	var sig;
	sig = SinOsc.ar(freq);
		i.postln;
		sig = sig * 0.5 * (0.75.pow(i));
	sig!2;
	}.play;
});
)





//Bonus Question (+1 pt)
//Modify your work from the final problem to generate 40 SinOsc generators instead of 20. Each of the original 20 oscillators should have a nearly-identical twin; the only difference between each original and its copy is that the frequency of each new copy should be slightly higher than its original, by a random float amount between 0.0 and 4.0. Sonically, the result should be similar, but now with a slow pulsing, beating sound. (Hint: the stutter method may be useful).

//your frequency array might look something like:
[150, 153.47338628769, 250, 251.30930900574, 300, 302.16426753998, ...etc... ]

rrand(0, 4)


~richFifties = ~expFifties.collect{arg n; {n + rrand(0.0, 4.0)}.value }
~richFifties = ~richFifties ++ ~expFifties
~richFifties.sort

(
~richFifties.do({
	arg freq, i;
	{
	var sig;
	sig = SinOsc.ar(freq);
		i.postln;
		sig = sig * 0.25 * (0.75.pow(i));
	sig!2;
	}.play;
});
)


//Ed's solution:
(
var newArray;
newArray = ~expFifties.sort.stutter;
newArray;
newArray.do({
	arg n, i;
	if (i.odd, {n = n + rrand(0.0, 4.0)});
	{
		var sig;
		sig = SinOsc.ar(n);
		sig = sig * 0.1 * 0.75.pow(i/2);
		sig!2;
	}.play;
});
)

)



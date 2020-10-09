// further reading: ctrl&shift&D, SuperCollider 3 Server Tutorial
// Client vs Server
// server architecture

//first boot server us unc ctrl & b or
Server.local.boot;

s.quit // quits the server. s is a default global for server.

{SinOsc.ar}.play
// simple way to play sound. use ctrl & . (ctrl & period) to stop all sound

x={SinOsc.ar}.play
x.free
//works, because x is a function synth

x={SinOsc.ar}
x.play
x.free
//does not work because x is a function defined in line 1
// in line 2 the function is evaluated as a synth andplayed, but the synth is not stored in its own variable so is inaccessible.
// in line 3 SuperCollider tries to free the function stored in x

x={SinOsc.ar}
y = x.play //fixes the above issue
y.free

// UGens

//further reading  Browse: UGens, Tour of UGens, Unit Generators and Synths

/* class methods .ar, .kr, .ir evaluate differfent numbers of samples for each wave. kr only evaluates each 64th sample compared to its .ar equivalent. .ir only evaluates the firt sample when the synth is initiaised*/

// one Ugen is SinOsc. The normal order of arguments is freq,phase,mul,add
// mul and add are really common and are often the last two args of a class.
// notice how we skip over phase and explicitly specify a value for mul
(
x = {SinOsc.ar(550, pi/2 , 0.2, 0)}.play;
y = {SinOsc.ar(770, mul: 0.2)}.play;
)
x.free
y.free

//as an alternative for mul and add, you can just multiply by or add a value

(
x = {SinOsc.ar(550, pi/2) * 0.2}.play;
y = {SinOsc.ar(770) * 0.2}.play;
)
s.scope
x.free
y.free

// ARGS
// functions can also have arguments, which can be changed even after the function is defined. if args and vars are used, args come 1st, then vars, then the rest of your code:
(
z = {
	arg freq = 500, amp = 1;
	var sig;
	sig = SinOsc.ar(freq, 0, amp, 0);
}.play;
)
z.set( \amp, 0.4);
z.set(\amp 0.5, \freq 888);
z.free
// the order in a set command does not have to match the order in which they are declared.

(
z = {
	var freq, sig, step_rate;
	step_rate = 20;
	freq = LFNoise0.kr(8,400,600) ;
	sig = SinOsc.ar(freq);
	// 8 is num of random values / s
	// default output -1:1, multiply output of LFNoise0 by 400 thhen add 600 so  actual putput is between 200 and 1000Hz
}.play;
)
z.free;


//All UGens understand XRANGE and RANGE:
(
z = {
	arg step_rate = 20;
	var freq, sig, amp;
	freq = LFNoise0.kr(step_rate).exprange(200,1000) ;
	amp = LFNoise1.kr(12).exprange(0.02,1);
	// range and exprange rescale the default values linearly or exponentialy
	sig = SinOsc.ar(freq) * amp;
	// 8 is num of random values / s
	// default output -1:1, multiply output of LFNoise0 by 400 thhen add 600 so  actual putput is between 200 and 1000Hz
}.play;
)
z.set(\step_rate,  5);

z.set(\step_rate, exprand(1,6));
//randomly selects a steprate between 1 and 6 each time we evaluate the state
z.free;




(
var mouse_freq;
mouse_freq = MouseX.kr(40,10000);
)







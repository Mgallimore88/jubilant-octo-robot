s.boot

// working with audio:

~clap = Buffer.read(s, "Documents/lmms/samples/LazerBlade sample collection/House/Percussions/House Percussion 01.wav")

~snap = Buffer.read(s, "Documents/lmms/samples/LazerBlade sample collection/House/Percussions/House Snap 02.wav")


~clap.play;
~snap.play;

~clap.numChannels;

~clap.duration; // seconds

~snap.numFrames; // samples (simultaneous across channels)

~clap.sampleRate; // server is running at one sample rate, audio files have sample rates, buffer and hardware have sample rates too.

~clap.bufnum
~snap.bufnum

Buffer.freeAll

// reading audio files in this fashion won't be compatible across different OS's or machines - the file paths would be different.
// Put the .scd program file and the audio files into the same folder so we use relative paths.

thisProcess.nowExecutingPath
//returns a string describing the location the file is being run from

PathName.new(thisProcess.nowExecutingPath);
// turns the string into a PathName object,

PathName.new(thisProcess.nowExecutingPath).parentPath;

(
// make a global variable called path use string concatenation to direct into the audio folder. Useful for sharing projects - zip up the folder and share.
~path = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "audio/";
~dub1 = Buffer.read(s, ~path ++"Dubstep Effect 1.wav");
~dub2 = Buffer.read(s, ~path ++"Dubstep Effect 2.wav");
)
~dub1.play;
~dub1.plot; //

~dub1.numChannels

// there are two UNIT GENERATORS WHICH PLAY BUFFERS - BufRd and PlayBuf

(
{
var sig;
	sig = PlayBuf.ar(
		2,
		~dub1.bufnum,
		loop:1
	);
	sig = sig * 0.2;
	}.play
)

(
{
var sig;
	sig = PlayBuf.ar(
		2,
		~dub2.bufnum,
		rate: BufRateScale.ir(~dub2.bufnum).poll,
		doneAction:2;
	);
	sig = sig * 0.2;
	}.play
)
// rate takes a ratio value - default 1 if the sample and the server are both at the same sample rate eg 44.1khz - but if the sample is recorded at a different sample rate, BufRateScale will yield "Buffer rate scaling in respect to server samplerate". .poll just outputs 1's becase they are the same for this sample, but changing the server sample rate will show a different ratio.
s.meter
// looking at node tree shows that the first sample doesn't release from the node tree, and there's some meter activity too - the buffer is outputting DC offset from the end of the audio file. use doneAction:2 to end the buf



// can not dynamically change the number of channels

(
x = {
	//n = semitiones from fundamental
arg n = 1, fund = 440;
var freq;
freq = fund*2.pow(n/12);
}
)

// a neater way is
440 * 12.midiratio
// this will provide the ratio to multiply a fundamental by in order to shift by an amount of semitones. Can be used as a multiplier for Rate after BufRateScale is established:


~dub2.numFrames
(
x = {
arg t_trig=1;
var sig;
	sig = PlayBuf.ar(
		2,
		~dub2.bufnum,
		BufRateScale.ir(~dub2.bufnum)* -8.midiratio,
		t_trig,
		20000, //start position
		doneAction:0; // to enable t_trig to retrigger
	);
	sig = sig * 0.2;
	}.play
)
x.set(\t_trig, 1);
x.free;

// IMPULSE AND DUST can be used as trigger events

Impulse.kr(8); // outputs 8 impulses per second

Dust.ar(8); // outputs an average of 8 impulses per second randomly spaced


a = [];

(
a=a.add({
arg t_trig=1;
var sig;
	sig = PlayBuf.ar(
		2,
		~dub2.bufnum,
		BufRateScale.ir(~dub2.bufnum)* -0.midiratio,
		Dust.kr(4),
		5000, //start position
		doneAction:0; // to enable t_trig to retrigger
	);
	sig = sig * 0.1;
	}.play
))
x.set(\t_trig, Dust.ar(8)); // doesn't work
x.free;

a.do({ arg n; n.set(\gate, 0, \fadeTime, 5) });







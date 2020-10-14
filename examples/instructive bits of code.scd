(
{ var ampOsc;
	ampOsc = SinOsc.kr(MouseX);
    SinOsc.ar(440, 0, ampOsc);
}.play;
)

4.do({"test".postln})


[1, 2, 3].stutter(2).postln;

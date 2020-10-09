// we can also pass in a sequence instead of an integer for degree, using Pseq([list of ints], num of repeats)

Pbind(\degree, Pseq([0, 9, 7, 5,3,1,-1,-3],4), \dur, 0.2).play;
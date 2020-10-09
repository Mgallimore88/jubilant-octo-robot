

// TYPES //

p = "string";
q = \symbol;
r = $c; //character

p.class;
q.class;
r.class;


// ARRAYS //

x = [1, 2, 3, 4];
y = [1, 2.6, \text, $y, "hi" ];


x;
y;
x.size;
y.size;
x.class;

// size returns the size of an array
// at returnsn the item at index, starting from 0. shortcut is x[3]

y.at(0)
y.at(4)
y[4]

// other methods include

at, put, add, insert

x.put(2, 500);

x.add(6000);
x
x.size

// arrays have a fixed size in supercollider, so even after 6000 is added to the end of the array, x is still only 4 entries long. To fix this, use x=x.add(num)

x = x.add(6000)

x = x.insert(1, 500);
x.size


x = x.scramble;
x = x.reverse;

x = [1,2,3,4,5];

x = x.mirror;
x = x.mirror2;

x.sort;

x = x.rotate(1);
x = x.rotate(2);

x.choose;

x;

x + 2;
x * 2; // applies operator to each item in array.

x.odd;// returns an array of booleans

x.squared;

x.isPrime; // not defined for arrays - only for integers. Solution is to iterate across the array.


// ITERATIVE METHODS //

collect, do, select, reject, any

[].collect{}; executes the function for each item in the array

[50, 60, 70, 80].collect({"hello".scramble.postln});

// the scramble is applied to hello for each of the four items in the list.

[50, 60, 70, 80].collect({arg m; ("hello " ++ m).postln});

// now the elements of the array are included in the function. we can now check whether there are any primes in the array.


x = [50, 60, 70, 80, 7];
x.collect({arg n; (n.isPrime)});

// horray!

// "do" is very similar but does not return the new array, it only returns the original array. The function is still executed each time. So DO is useful when the function just needs to be executed and we are not interested in collectin modified values.

x.do({arg n; (n.isPrime.postln)});


x.select({arg m; m.isPrime});
// selects the items in array x for which the function returns true.

x.reject({arg m; m.isPrime});

x.any // checks if any items in the array return true when passed to the function.

// GETTING THE INDEX //
(
[20, 30, 40, 50, 60].do({
	arg n, index;
	[n,index].postln;
})
)

// the word index can just be i, and the arg n; can be replaced by |n| with no semicolon.

(
[20, 30, 40, 50, 60].do({
	|n, i|
	[n,i].postln;
})
)


// CREATING NEW ARRAYS WITH METHODS //

x = Array.new(5);
x = Array.series(8, 5,1);
x = Array.series(8, 5, -2);
x = Array.geom(8, 2, 0.5);
x = Array.interpolation(8, 100, 180);
x = Array.fill(5, 3);
x = Array.fill(7, {"hello".scramble});

// RAND

rrand(3,5) // ranged rand number between 3 and 5

// there are many different probability distributions available. see the online help file https://doc.sccode.org/Guides/Randomness.html


exprand(1,100) // tends to the lowest number, higher numbers are less probable.

exprand(-1,-100)
// both numbers have to be the same sign. otherwise NaN

exprand(1,100).neg
// same as above


Array.exprand(8, 1, 100);

Array.rand(8, 1, 100);

Array.rand(8, 1.0, 100);


Array.fill(8, {rrand(1,100)});
Array.fill(8, rrand(1,100));
// notice that if FILL is not passed a function, the value is not evaluated uniquely for each entry in the array.

Array.series(100, 1, 1); // populates an array from 1 to 100

(1..100) // shorthand for above
(1, 4..100) // in steps of 4



// PLAY AN ARRAY OF SIN WAVES - simple additive synthesis
Server.local.boot
s.meter


(
x = Array.exprand(8, 200, 2000);
x.do({
	arg n, i;
	{
		var sig;
		sig = SinOsc.ar(n);
		sig = sig/8;
		sig!2;
	}.play;
});
)


// we can modfy the above code to control the volume of each frequency with bias to the lower or higher freqs, quantise the frequencies to the nearest multiple of a certain harmonic.

(
x = Array.exprand(8, 200, 1000).round(100);
x = x.sort; // sort the array
x.do({
	arg n, i;
	var amp;
	amp = 1/(i+1); //reciprocal, +1 *
	amp = amp * 0.2;
	amp.postln;
	{
		var sig;
		sig = SinOsc.ar(n);
		sig = sig * amp;
		sig!2;
	}.play;
});
)

// *  so numbers start at 1 not zero

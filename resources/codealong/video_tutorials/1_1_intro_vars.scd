// "//" comments out a single line of code.
// to execute code in brackets, hit ctrl & enter

//the form of operaration in the language is
// "receiver.message" as in 3.cubed 3 is the receiver, cubed is the message

// single letters 'f' 'a' etc are automatically reserved as global variables.

(
f = 3.cubed;
f
)
f

/* local variables need defining using 'var' before use. their scope is limited to the block of code in which they are defined, and they disappear once the code is evaluated. and lookl at this comment style */

(
var number;
number = 3.squared;
)
// typing number here returns an error since the number variable has gone.
number

//declare global variable
(
~number = 3.cubed;
~number
)
~number

// seperating operations onto new lines makes them easier to read.
//the following code can be written in two ways:

//one liner
var foo = 3.cubed + 100 / 2; foo

// easier to read
(
var foo;
foo = 3;
foo = foo.cubed;
foo = foo + 100;
foo = foo / 2;
foo;
)

// if foo isn't reassigned on each line this happens

(
var foo;
foo = 3;
foo.cubed;
foo + 100;
foo / 2;
foo;
)

//notice the last line goes to the post window
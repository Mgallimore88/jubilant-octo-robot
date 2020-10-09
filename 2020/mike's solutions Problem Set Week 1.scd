//Problem Set Week 1

//First, save this scd file as a new file, renaming it with your Last name at the beginning of the file name (e.g. "Fieldsteel Problem Set Week 1.scd"), and upload this renamed file to the course website for your submission.

//Problem 1
//The following code produces an error. Correct the error and add a comment indicating the problem (comments are created by starting a line with two forward slashes, exactly like this line).

(
var apples;
apples = 3;
apples = apples * 2;
apples = apples - 1;
)
// The local variable apples was not declared.

(
~apples = 3;
~apples = ~apples * 2;
~apples = ~apples - 1;
)
// alternate solution is to use tildas to make apples a global variable.

(
~a = 3;
~a = ~a * 2;
~a = ~a - 1;
)
// or to use one of the 26 lower case global variables a-z (s is reserved for server)





//Problem 2
//The following code produces an error. Correct the error and add a comment indicating the problem.

(
var oldBalance, deposit, newBalance;
oldBalance = 5;
deposit = 100;
newBalance = oldBalance + deposit;
)
// There was semicolon missing from the end of the vars


//Problem 3
//The following code produces an error. Correct the error and add a comment indicating the problem.

(
var classroomSize, numClasses, totalStudents;
classroomSize = 30;
numClasses = 4;
totalStudents = classroomSize * numClasses;
)
// typo in students / studnets



//Problem 4
//The following code produces an error. Correct the error and add a comment indicating the problem.

(
~func = {
	arg x=5, y=6, z=7;
	var product;
	product = x * y * z;
};
)
~func.value;



//Problem 5
//The following code returns a boolean indicating whether the square of 45 is an odd number, and is written in the "receiver.method" style. Rewrite it in the "method(receiver)" style.

45.squared.odd;
odd(squared(45));



//Problem 6
//The following conditional check prints whether a random float between 0 and 1 is greater than 0.5 or not, and is written in the "method(receiver)" style. Rewrite it so that all instances of this syntax style are converted to the "receiver.method" style.

(
if(
	1.0.rand.postln > 0.5,
	{"is greater than 0.5".postln},
	{"is not greater than 0.5".postln}
);
)




//Problem 7
//Write a function that accepts three input arguments. If all three inputs are members of the same class (e.g. 1, 4, 500), return the string "same". If not (e.g. "hello", 6.1, 99), return the string "different". Write an additional few lines of code that demonstrate the use of this function.

(
~func = {
	arg arg1, arg2, arg3;
	arg1.postln;
	arg1.class.postln;
	arg2.postln;
	arg2.class.postln;
	arg3.postln;
	arg3.class.postln;

	if(
		(arg1.class == arg2.class) && (arg2.class == arg3.class),
		{"The classes are the SAME"},
		{"The classes are DIFFERENT"}
	)
}
)
~func.value(1,2,3);
~func.value("pies", "chips", "peas");
~func.value("pies", 6.0, 55);



//Problem 8
//Write a function that checks whether a number is a multiple of 100. If so, return that number. If not, return the nearest multiple of 100. If the input  provided is not a number, return the string "not a number". Write an additional few lines of code that demonstrate the use of this function.
(
~nearest_hundred = {
	arg input;
	if(
		(input.class == Float) || (input.class == Integer),
		{
				if(
					input.mod(100) == 0,
					{input.postln},
					{input.round(100).postln};
				)
		},
		{"not a number".postln};
	   )
	}
)

~nearest_hundred.value(188);


//Problem 9
//Write a function that checks whether an incoming value (representing a frequency memasured in Hz) is within the generally-accepted audible range of human hearing (not less than 20 and not greater than 20000). If it's within range, return the string: "play tone at xxx Hz". If it's not within this range, return the string "xxx Hz not within range". The actual number should replace the xxx in both cases. (Note: you can use the method "asString" to convert a number to a string. If the input is not a number, the function should return the string "invalid input". Write an additional few lines of code that demonstrate the use of this function.

(
~audible_range_checker = {
	arg input;

	if(
		(input.class == Integer) || (input.class == Float),

		{
			if(
			(input >= 20) && (input <= 20000),
			{"play tone at "++ input.asString ++" hz"},
			{input.asString ++ " Hz not in audible range"};)
		},

		{"invalid input"};
	)
}
)
~audible_range_checker.value(1);


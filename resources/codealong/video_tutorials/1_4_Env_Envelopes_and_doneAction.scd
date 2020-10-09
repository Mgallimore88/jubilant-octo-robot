Server.local.boot
s.quit

/* EnvGen
-uses a class of objects called Env
- has a gate argument meaning it can be suatained indefinitely and be retriggered
 Env is a specification for a breakpoint envelope shape
- has funtionality in sclang and server */

Env.new.plot; // default env is a simple triangle
// *new (levels: [ 0, 1, 0 ], times: [ 1, 1 ], curve: 'lin', releaseNode, loopNode, offset: 0)
// levels are the amplitude levels of the env, times are the times taken to reach levels.
// ctrl + d Env


(
{
	var sig, env;
	env = EnvGen.kr(Env.new, doneAction: 2);
	sig = Pulse.ar(ExpRand(30, 500)) * env;
}.play
)

Env.new([0,1,0.5,0],[0.2,0.1,1], 'lin').plot;  // 4 level vals needs 3 time vals.
/* the lines are all linear. Remember exponentional curves are undefined for values of
zero, so either use very small starting values: */
Env.new([0.001,1,0.5,0.001],[0.2,0.1,1], 'exp').plot;

/* Or better, specify the second rates of change for the curve in another arg. positive values make the rate of change start low then increase whereas negative vals make a steep initial rate of change which levels out. */

Env.new([0,1,0.5,0],[0.2,0.1,1], [3, -3, 0] ).plot; // need 1 curve val for each segment.

// many possible args for shape of curve segments:

Env.new([0,1,0.1, 0.5,0],[0.2,0.1, 2,1], [3, -3, \sine, 0] ).plot; // need 1 curve val for each segment.

// paste into 1st example in place of default env

(
{
	var sig, env;
	env = EnvGen.kr(Env.new([0,1,0.1, 0.5,0],[0.2,0.1, 2,1], [3, -3, \sine, 0] ), doneAction: 2);
	sig = Pulse.ar(ExpRand(30, 500)) * env;
}.play
)


	
// Start the server
s.boot;

// Create a some synthdefs and some patterns
(
	SynthDef.new(\synth1,
		{
			arg freq, ratio, modIndex, amp, atk, dec, sus, rel, panSpeed, panOffset, modAtk, modDec, modIndexSus;
			var env, modEnv, a, b, c, d, fmOut, pan;
			env = Env.new([0, 1, sus, 0],[atk, dec, rel],[0, -4, -4]);
			modEnv = Env.new([0, modIndex, modIndex, modIndexSus],[modAtk, 0, modDec],[0, 0, -8]);
			8.do{
				freq = freq+LFNoise2.ar(1/64).range(-1/32, 1/32);
				ratio = ratio+LFNoise2.ar(1/64).range(-1/32, 1/32);
				a = freq*ratio;
				b = a * EnvGen.kr(modEnv);
				c = SinOsc.ar(a) * b;
				d = freq + c;
				fmOut = (SinOsc.ar(d) * EnvGen.kr(env, doneAction: 2));
				pan = LFNoise1.ar(1/8).range(-0.8, 0.8);
				Out.ar(0, Pan2.ar(fmOut, pan, amp)*0.0625);
			};
		}
	).add;

	SynthDef.new(\kick,
		{
			var pitch, amp, fmOut, envGen, modEnv, ratio, a, b, c, d;
			envGen = Env.new([0, 1, 0.125, 0],[0.01, 0.15, 0.4],[-4, -4, -4]);
			modEnv = Env.new([4, 0.5],[1],[-32]);
			3.do{
				pitch = XLine.ar(1000, 50, 0.01);
				ratio = 0.75+LFNoise2.ar(0.125).range(-1/32, 1/32);
				a = pitch*ratio;
				b = a * EnvGen.kr(modEnv);
				c = SinOsc.ar(a) * b;
				d = pitch + c;
				fmOut = (SinOsc.ar(d) * EnvGen.kr(envGen, doneAction: 2));
				Out.ar(0, Pan2.ar(fmOut, 0, 0.3));
			};
		}
	).add;
	
	Pdef(
		\melody1,
		Pbind(
			\instrument, \synth1,
			\choice, Pwrand([0, 1, 2, 3, 4, 5, 6], [1, 2, 4, 10, 4, 2, 1].normalizeSum, inf),
			\dur, Pindex([Pseq([0.25], 2), 2.0, 1.0, Pseq([0.5], 2), 1.0, 2.0, Pseq([0.25], 2)], Pkey(\choice), inf) * 0.5,
			\freq, Pindex((Scale.phrygian.degrees+48).midicps, Pkey(\choice), inf),
			\amp, Pseq([1.0, 0.5, 0.25, 0.25], inf),
			\atk, Pseq([0.01], inf),
			\dec, Pexprand(0.2, 0.8, inf),
			\sus, Pseq([0.25], inf),
			\rel, Pseq([Pseq([1], 8), Pseq([12], 4)], inf),
			\modAtk, Pseq([0.0], inf),
			\modDec, Pseq([Pseq([0.1], 8), Pseq([0.7], 2)], inf),
			\modIndex, Pexprand(4, 10, inf),
			\modIndexSus, Pkey(\modIndex) * 0.125,
			\ratio, Pxrand([1.0, 0.5, 2.0, 4.0], inf),
			\panSpeed, Pseq([1], inf),
			\panOffset, Pexprand(0.0001, 1, inf)
		);
	).play;
	
	Pdef(
		\melody2,
		Pbind(
			\instrument, \synth1,
			\choice, Pwrand([0, 1, 2, 3, 4, 5, 6], [1, 2, 4, 2, 4, 10, 1].normalizeSum, inf),
			\dur, Pindex([Pseq([0.25], 2), 2.0, 1.0, Pseq([0.5], 2), 1.0, 2.0, Pseq([0.25], 2)], Pkey(\choice), inf) * 0.5,
			\freq, Pindex((Scale.phrygian.degrees+72).midicps, Pkey(\choice), inf),
			\amp, Pseq([1.0, 0.5, 0.75, 0.25], inf) * 0.5,
			\atk, Pseq([0.02], inf),
			\dec, Pexprand(0.2, 0.8, inf),
			\sus, Pseq([0.25], inf),
			\rel, Pseq([Pseq([1], 8), Pseq([12], 4)], inf),
			\modAtk, Pseq([0.0], inf),
			\modDec, Pseq([Pseq([0.1], 6), Pseq([0.7], 2)], inf),
			\modIndex, Pexprand(4, 20, inf) * 2.0,
			\modIndexSus, Pkey(\modIndex) * 0.125,
			\ratio, Pxrand([1.0, 0.5, 2.0, 0.25], inf),
			\panSpeed, Pseq([0.25], inf),
			\panOffset, Pexprand(0.0001, 1, inf)
		);
	).play;
	
	Pdef(
		\melody3,
		Pbind(
			\instrument, \synth1,
			\choice, Pwrand([0, 1, 2, 3, 4, 5, 6], [1, 2, 4, 2, 4, 10, 1].normalizeSum, inf),
			\dur, Pindex([Pseq([0.25], 2), 2.0, 1.0, Pseq([0.5], 2), 1.0, 2.0, Pseq([0.25], 2)], Pkey(\choice), inf) * 4.0,
			\freq, Pindex((Scale.phrygian.degrees+48).midicps, Pkey(\choice), inf),
			\amp, Pseq([0.25, 0.5, 1.0, 0.25], inf) * 0.5,
			\atk, Pseq([2], inf),
			\dec, Pseq([2], inf),
			\sus, Pseq([0.25], inf),
			\rel, Pseq([6], inf),
			\modAtk, Pseq([3.0], inf),
			\modDec, Pseq([3.0], inf),
			\modIndex, Pexprand(4, 20, inf) * 0.25,
			\modIndexSus, Pkey(\modIndex) * 0.125,
			\ratio, Pxrand([1.0, 0.5, 2.0, 0.25], inf),
			\panSpeed, Pseq([0.75], inf),
			\panOffset, Pexprand(0.0001, 1, inf)
		);
	).play;

	Pdef(
		\kickPat,
		Pbind(
			\instrument, \kick,
			\dur, Pseq([1/2], inf)
		);
	).play;

)

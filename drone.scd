s.boot;
s.quit;

(
	SynthDef.new(\drone,
		{
			arg pitch, pRange, pSpeed, res;
			var sig, env, envGen, filt;
			env = Env.new([0,1,0.25,0],[250,250,500],[-4,-4,-4]);
			envGen = EnvGen.ar(env, doneAction: 2);
			sig = WhiteNoise.ar() * envGen;
			filt = BPF.ar(sig, pitch + LFNoise1.ar(pSpeed).range(pRange * -1, pRange), res);
			Out.ar(0, Pan2.ar(filt, LFNoise1.ar(1/64).range(-1, 1), 4));
		}
	).add;
)

(
	20.do{
		arg item;
		a = Synth(\drone, [
			\pitch, 125,
			\pRange, 125*0.5,
			\pSpeed, 1/4,
			\res, 0.0001
		]);
	}
)

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
			filt = BPF.ar(sig, pitch + LFNoise2.ar(pSpeed).range(pRange * -1, pRange), res);
			Out.ar(0, Pan2.ar(filt, LFNoise2.ar(1/64).range(-1, 1), 4));
		}
	).add;
)

(
	var list = [1,2,4,6,8,12,16];
	list.do{
		arg i;
		20.do{
			Synth(\drone, [
				\pitch, 62.5*i,
				\pRange, 3*i,
				\pSpeed, 1/128,
				\res, 0.0001
			]);
		}
	}
)

a.free;

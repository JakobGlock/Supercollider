s.boot;
s.quit;

(
	SynthDef.new(\drone,
		{
			arg pitch;
			var sig, env, envGen, filt;
			env = Env.new([0,1,0.25,0],[45,45,90],[-4,-4,-4]);
			envGen = EnvGen.ar(env, doneAction: 2);
			sig = WhiteNoise.ar() * envGen;
			filt = BPF.ar(sig, pitch + LFNoise1.ar(1/128).range(-20, 20), 0.0001);
			Out.ar(0, Pan2.ar(filt, LFNoise1.ar(1/64).range(-1, 1), 4));
		}
	).add;
)

(
	10.do{
		arg item;
		a = Synth(\drone, [\pitch, 250]);
	}
)

s.boot;
s.quit;

(
	SynthDef.new(\drone,
		{
			arg pitch, pRange, pSpeed, res;
			var sig, env, envGen, filt;
			env = Env.new([0,1,0.25,0],[250,250,500],[0,0,0]);
			envGen = EnvGen.ar(env, doneAction: 2);
			sig = WhiteNoise.ar();
			filt = BPF.ar(sig, pitch + LFNoise2.ar(pSpeed).range(pRange * -1, pRange), res);
			Out.ar(0, Pan2.ar(filt*envGen, LFNoise2.ar(1/64).range(-1, 1), 4));
		}
	).add;
)

(
	var speed = [1/4,1/8,1/16,1/32,1/64,1/128];
	var list = [1,2,4,6,8,12,16];
	list.do{
		arg i;
		i.do{
			Synth(\drone, [
				\pitch, (Scale.minor.degrees+24).choose*i,
				\pRange, 3*i,
				\pSpeed, speed.choose,
				\res, 1/(1024 * i)
			]);
		}
	}
)

a.free;

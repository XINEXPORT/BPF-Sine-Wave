(
SynthDef(\bpfsin,{
	arg atk=2, sus=2, rel=4, c1=1, c2=(-1),
	freq=600, cf=1500, rq=0.2, amp=1, out=0, detune=0.2, pan=0,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel], [c1,0,c2]),doneAction:2);
	sig = SinOsc.ar (freq * LFNoise1.kr (0.5,detune).midiratio);
	sig = BPF.ar (
		sig,
		LFNoise1.kr(0.2). exprange(cfmin, cfmax),
		LFNoise1.kr(0.1). exprange(rqmin, rqmax),
	);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);
}). add;
)

(1..10).choose.do {Synth(\bpfsin, [\amp,0.5, \detune, 3])};

(
10.do{
	Synth(
		\bpfsin,
		[
			\freq, 100,
			\amp, 10,
			\cfmin,50*4,
			\cfmax,50*50,
			\rqmin, 0.005*3,
			\rqmax,0.03,
			\pan,1,
		],
	);
};
)
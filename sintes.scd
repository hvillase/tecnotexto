//=============================
// TecnoTexto Synths
//=============================

(
// --- sine
(
SynthDef(\sine, {|freq = 400, pi1=0, a1 = 0.5, p1 = 0, at1 = 0.01, r1 = 0.1, o1 = 0|
var sen, env;
sen = SinOsc.ar(freq, pi1, a1);
sen = Pan2.ar(sen, p1);
env = EnvGen.kr(Env.perc(at1, r1), doneAction:2);
Out.ar(o1, sen * env);
}).add
);

// --- saw tooth
(
SynthDef(\saw,{|freq=300, a2=0.3, p2=0, at2=0.01, r2=0.09, o2=0|
var sen, env;
sen = Saw.ar(freq, a2);
sen = Pan2.ar(sen, p2);
env = EnvGen.kr(Env.perc(at2, r2), doneAction:2);
Out.ar(o2, sen * env)
}).add
);

// --- triangular
(
SynthDef(\lftri, {|freq=300, a3=0.45, p3=0, at3=0.01, r3=0.03, o3=0|
	var sen, paneo, env;
	sen = LFTri.ar(freq, 0, a3);
	paneo = Pan2.ar(sen, p3);
	env = EnvGen.kr(Env.perc(at3, r3), doneAction:2);
	Out.ar(o3, paneo * env)
}).add
);

// --- pulse
(
SynthDef(\pulse,{|freq = 100, a4 = 0.2, p4 = 0, pw4 = 0.5, at4 = 0.01, r4 = 0.5, o4 = 0|
var sen, env;
	sen=Pulse.ar(freq, pw4, a4);
	sen=Pan2.ar(sen, p4);
	env=EnvGen.kr(Env.perc(at4, r4), doneAction:2);
Out.ar(o4, sen * env)
}).add
);

// --- wnoise
(
SynthDef(\wnoise,{|a5 = 0.5, p5 = 0, at5 = 0.1, r5 = 0.5, o5 = 0|
var sen, env;
	sen = WhiteNoise.ar(a5);
	sen = Pan2.ar(sen, p5);
	env = EnvGen.kr(Env.perc(at5, r5), doneAction:2);
Out.ar(o5, sen * env)
}).add);

// --- silence
(
SynthDef(\s, {|as = 0|
var sen, env;
	sen = Silent.ar;
	env = EnvGen.kr(Env.perc(0.01, 0.1), doneAction:2);
Out.ar(0, sen * env);
}).add
);

//================================
// effects
//================================

// --- reverb - bus 9
(
SynthDef(\rev1, {|mix = 0.4, room = 0.9, damp = 0.1, amp = 1, gate = 1, out = 0|
	var sen, env;
	sen = FreeVerb.ar(InFeedback.ar(9, 2), mix, room, damp, amp);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.1), gate, doneAction: 0);
	Out.ar(out, sen * env);
}).add
);

// --- delay - bus 11, mdt = maxdelayTime, dt = delayTime, dct = decayTime
(
SynthDef(\delay1, {|mdt = 0.3, dt = 0.25, dct = 2, gate = 1, out = 0|
var del, env;
	del = CombL.ar(InFeedback.ar(11, 2), mdt, dt, dct);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, del * env);
}).add
);

// --- lpf - bus 13
(
SynthDef(\lpf, {|cfl = 100, gate = 1,  out = 0|
	var lpf, env;
	lpf = LPF.ar(InFeedback.ar(13, 2), cfl, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, lpf * env);
}).add
);

// --- hpf - bus 15
(
SynthDef(\hpf, {|cfh = 1000, gate = 1, out = 0|
	var hpf, env;
	hpf = HPF.ar(InFeedback.ar(15, 2), cfh, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, hpf * env);
}).add
);

// --- bpf - bus 17
(
SynthDef(\bpf, {|cfb = 1000, st = 500, end = 1000, dur = 2, rq = 1, gate = 1, out = 0|
	var line, bpf, env;
	line = Line.kr(st, end, dur);
	bpf = BPF.ar(InFeedback.ar(17, 2), cfb, rq, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, bpf * env);
}).add
);

);
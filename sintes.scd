//==========================
// Librería sintes hvillase
//==========================

// InFeedback: 9, 11, 13, 15, 17, 19, 21
// los argumentos de los efectos pueden ser genericos, es decir la salidad de todos puede ser \out, etc. para disminuir carga cognitiva
// Posibles conflictos con clase Diluir en el InFeedback, a partir del In 19
// Reglas de sintáxis para el performance.
// Otra idea es mantener argumentos estandar.
// Sintaxis \key de sintes: parametro/número/identificador (at1==ataque, sine), (at2g==ataque, saw, con gate)
// Sintes: sine, saw, lftri, pulse, wnoise; sawg; bd, bd2, kick, sd, hh, clap; silencio; sawf, lftrif, pulsef; rev1, rev2;
// Nemotemia: sslpw == san luis potosi wow;
// Desambiguar letras: parametros que empiezan con misma letra. El segundo usa dos primeras consonantes. ej. p=pan pl=pulse; a=amp, at=ataque
// Silencios: afinados con freq, percusivos con amp.
// Usar envolvente de frecuencia.
// (f) = efecto o especial: sawf, lftrif, pulsef; psw?
// (g) = sintes con gate: sawg;
// Cómo cambiar la duración de los buffers? quizá hacer varios.
// Agregar argmento pi a sine.
// Scale 1b (bemol) 1s (sharp).
// preparar Pdefs en blanco y ritmos sencillos para arrancar en semicero
// como resolver amp para usar db, una opción es hacer un multiplicador aparte para compensar diferencias
// cómo guardar buffers en un baco de sonidos;
// cómo interconctar efectos;
// cómo mandar mensages a los sintes sin variables

(
// === GRABACION y wavetable
~durb1 = 5;
~durb2 = 5;
~b1 = Buffer.alloc(s, s.sampleRate * ~durb1, 1); // mono
~b2 = Buffer.alloc(s, s.sampleRate * ~durb2, 2); // estereo
~b3 = Buffer.alloc(s, 1024, 1); // cheby

// --- grabar buffers
(
SynthDef(\b1rec, {|in = 0, ovdub = 0|
RecordBuf.ar(SoundIn.ar(in), ~b1.bufnum, 0, 1, ovdub, loop:0, doneAction:2);
}).add
);

(
SynthDef(\b2rec, {|in1 = 0, in2 = 1, ovdub = 0|
RecordBuf.ar(SoundIn.ar([in1, in2]), ~b2.bufnum, 0, 1, ovdub, loop:0, doneAction:2);
}).add
);

// --- reproduce buffer mono distor
(
SynthDef(\b1play, {|rate=1, st=0, p0=0, a0=1, at0=0.01, r0=0.1, o0=0|
	var sen, env;
	sen=PlayBuf.ar(~b1.numChannels, ~b1.bufnum, rate, startPos:st).trunc;
	sen=Pan2.ar(sen, p0, a0);
	env=EnvGen.kr(Env.perc(at0, r0), doneAction:2);
	Out.ar(o0, sen * env);
}).add
);

// --- reproduce buffer mono
(
SynthDef(\b1playl, {|rate=1, st=0, p0=0, a0=1, at0=0.01, r0=0.1, o0=0|
	var sen, env;
	sen = PlayBuf.ar(~b1.numChannels, ~b1.bufnum, rate, startPos:st);
	sen = Pan2.ar(sen, p0, a0);
	env = EnvGen.kr(Env.perc(at0, r0), doneAction:2);
	Out.ar(o0, sen * env);
}).add
);

// --- reproduce buffer estéreo
(
SynthDef(\b2play, {|rate=1, st=0, a0s=1, t10s=0.1, t20s=1, t30s=0.1, o0s=0|
	var sen, env;
	sen = PlayBuf.ar(~b2.numChannels, ~b2.bufnum, rate, startPos:st);
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t10s, t20s, t30s] ), doneAction:2);
	Out.ar(o0s, (sen * env) * a0s);
}).add
);

// --- reproduce sonido desde disco duro; stream
/*(
SynthDef(\s1play, {|o=0|
	var sen, env;
	Out(o, sen * env)
}).add
)*/

// === AFINADOS

// --- sine
(
SynthDef(\sine, {|freq = 400, pi1=0, a1 = 0.5, p1 = 0, at1 = 0.1, r1 = 0.1, o1 = 0|
var sen, env;
sen = SinOsc.ar(freq, pi1, a1);
sen = Pan2.ar(sen, p1);
env = EnvGen.kr(Env.perc(at1, r1), doneAction:2);
Out.ar(o1, sen * env);
}).add
);

// --- saw
(
SynthDef(\saw,{|freq=300, a2=0.5, p2=0, at2=0.1, r2=0.1, o2=0|
var sen, env;
sen = Saw.ar(freq, a2);
sen = Pan2.ar(sen, p2);
env = EnvGen.kr(Env.perc(at2, r2), doneAction:2);
Out.ar(o2, sen * env)
}).add
);

// --- sawg
(
SynthDef(\sawg,{|freq=300, a2g=0.5, p2g=0, at2g=0.1, gate=1, r2g=0.1, o2g=0|
var sen, env;
sen = Saw.ar(freq, a2g);
sen = Pan2.ar(sen, p2g);
env = EnvGen.kr(Env.asr(at2g, a2g, r2g), gate, doneAction:0);
Out.ar(o2g, sen * env)
}).add
);

// --- lftri
(
SynthDef(\lftri, {|freq=300, a3=0.5, p3=0, at3=0.1, r3=0.1, o3=0|
	var sen, env;
	sen=LFTri.ar(freq,0,a3);
	sen=Pan2.ar(sen,p3);
	env=EnvGen.kr(Env.perc(at3, r3), doneAction:2);
	Out.ar(o3, sen * env)
}).add
);

// --- pulse
(
SynthDef(\pulse,{|freq = 100, a4 = 0.5, p4 = 0, pw4 = 0.5, at4 = 0.01, r4 = 0.5, o4 = 0|
var sen, env;
	sen=Pulse.ar(freq, pw4, a4);
	sen=Pan2.ar(sen, p4);
	env=EnvGen.kr(Env.perc(at4, r4), doneAction:2);
Out.ar(o4, sen * env)
}).add
);

// --- wnoise
(
SynthDef(\wnoise,{|a5=0.5, p5=0, at5=0.01, r5=0.5, o5=0|
var sen, env;
	sen=WhiteNoise.ar(a5);
	sen=Pan2.ar(sen, p5);
	env=EnvGen.kr(Env.perc(at5, r5),doneAction:2);
Out.ar(o5, sen * env)
}).add);

// === PERCUSIVOS
// --- bd
(
SynthDef(\bd, {|fbd = 80, pibd=pi, abd = 0.75, pbd = 0, atbd = 0.01, rbd = 0.5, obd=0|
	var sen, env;
	sen = SinOsc.ar(fbd, pibd, abd);
	sen = Pan2.ar(sen, pbd);
	env = EnvGen.kr(Env.perc(atbd, rbd), doneAction:2);
	Out.ar(obd, sen * env);
}).add
);

// --- bd2, es lo mismo que kick, poner out
(
SynthDef(\bd2, {|fbd2=80, abd2=0.5, atbd2=0, rbd2=0.2, wrap=0.9, pbd2=0|
	var sig, env;
	sig = SinOsc.ar(Line.kr(fbd2*3,[fbd2,fbd2*1.8],0.05),pi/2,abd2).wrap2(wrap);
	sig = Pan2.ar(sig, pbd2);
	env = EnvGen.kr(Env.perc(atbd2, rbd2), doneAction:2);
	Out.ar(0, sig * env)
}).add
);

// --- kick
(
SynthDef(\kick, {|fk=80, ak=0.5, rk=0.2, wrap=0.9, pk=0|
var sig, env;
sig = SinOsc.ar(Line.kr(fk * 3,[fk, fk * 1.8], 0.05), pi/2, ak).wrap2(wrap);
sig = Pan2.ar(sig, pk);
env = EnvGen.kr(Env.perc(0, rk), doneAction:2);
Out.ar(0, sig * env)
}).add
);

// --- sd
(
SynthDef(\sd, {|fsd = 300, asd = 0.2, line = 250, osd = 0, psd=0|
	var sig, sig2, frec, env, env2;
	frec=XLine.kr([fsd, line], 100, 0.2);
	sig=SinOsc.ar(frec, 0, 0.7);
	sig = Pan2.ar(sig, psd);
	sig2=WhiteNoise.ar(0.3);
	sig2 = Pan2.ar(sig2, psd);
	env=EnvGen.kr(Env.perc(0.01,0.15,1,-7), doneAction:2);
	env2=EnvGen.kr(Env.perc(0.01,0.55,1,-7), doneAction:2);
	Out.ar(osd, ((sig * env) + (sig2 * env2)) * asd);
	}).add;
);

// --- hh
(
SynthDef(\hh, {|fhh=12000, ahh=0.4, phh=0, rhh=0.02|
var sen, env;
	sen = MoogFF.ar(WhiteNoise.ar(ahh), fhh);
	sen = Pan2.ar(sen, phh);
	env = EnvGen.kr(Env.perc(0.009, rhh), doneAction:2);
Out.ar(0, sen * env)
}).add
);

// --- hihat 2 by 
(// by rumush
SynthDef(\hh2, {|phh2 = 0, ahh2=1, rhh2 = 0.5|

var env1 = EnvGen.ar(Env.perc(0.001,rhh2,1,-16), doneAction:2);
var env2 = EnvGen.ar(Env.perc(0.001,rhh2/2,1,-16));
var src1 = PinkNoise.ar(1) + WhiteNoise.ar(0.5 * env2);
src1 = RHPF.ar(src1, 5000);
src1 = LPF.ar(src1, 15000);
src1 = Pan2.ar(src1, phh2);
	
Out.ar(0, (src1 * env1) * ahh2);
}).add
);

// --- clap by otophilia
(
SynthDef(\clap, {|oclap = 0, aclap = 0.5, pclap = 0|
var env1, env2, out, noise1, noise2;
		env1 = EnvGen.ar(Env.new([0, 1, 0, 1, 0, 1, 0, 1, 0], [0.001, 0.013, 0, 0.01, 0, 0.01, 0, 0.03], [0, -3, 0, -3, 0, -3, 0, -4]));
		env2 = EnvGen.ar(Env.new([0, 1, 0], [0.02, 0.3], [0, -4]), doneAction:2);

		noise1 = WhiteNoise.ar(env1);
		noise1 = HPF.ar(noise1, 600);
		noise1 = BPF.ar(noise1, 2000, 3);

		noise2 = WhiteNoise.ar(env2);
		noise2 = HPF.ar(noise2, 1000);
		noise2 = BPF.ar(noise2, 1200, 0.7, 0.7);

		out = noise1 + noise2;
		out = out * 2;
	    out = out.softclip * aclap;
	    out = Pan2.ar(out, pclap);

	Out.ar(oclap, out);
}).add
);

// --- silencio
(
SynthDef(\s, {|as = 0|
var sen, env;
	sen = Silent.ar;
	env = EnvGen.kr(Env.perc(0.01,0.1), doneAction:2);
Out.ar(0, sen * env);
}).add
);

// === ESPECIALES afinados (f)
// --- sawf
(
SynthDef(\sawf,{|freq=440, a2f=0.5, at2f=0.1, r2f=0.1, p2f=0.7, o2f=0|
    var sen, sen2, env;
    sen = Saw.ar(freq, a2f/2);
    sen = Pan2.ar(sen, p2f);
	sen2 = Saw.ar(freq + 1.2, a2f/2);
	sen2 = Pan2.ar(sen2, p2f.neg);
    env = EnvGen.kr(Env.perc(at2f, r2f), doneAction:2);
    Out.ar(o2f, (sen + sen2) * env);
}).add
);

// --- lftrif
(
SynthDef(\lftrif, {|freq=100, e3f1=0.2, e3f2=0.2, a3f=0.2, p3f=0, at3f=0.1, r3f=0.1, d3f=0.3, o3f=0|
var sen, env, lin;
	lin= EnvGen.kr(Env([freq, freq*1.5, freq*1.01], [e3f1, e3f2]), doneAction:0);
	sen= LFTri.ar(lin, 0, a3f) % d3f;
	sen= Pan2.ar(sen, p3f);
	env= EnvGen.kr(Env.perc(at3f, r3f), doneAction:2);
Out.ar(o3f, sen * env);
}).add
);

// ---pulsef
(
SynthDef(\pulsef,{|freq=100,fq4f=190,rq4f=1,a4f=0.5,p4f=0,pw4f=0.5,at4f=0.01,r4f=0.5,o4f=0|
var sen,filt,paneo,env;
	sen=Pulse.ar(freq, pw4f, a4f);
	filt=RHPF.ar(sen, fq4f, rq4f);
	paneo=Pan2.ar(filt, p4f);
	env=EnvGen.kr(Env.perc(at4f, r4f),doneAction:2);
Out.ar(o4f, paneo * env)
}).add
);

// ===============================
// PROCESOS EFECTOS TecnoTexto.fx
//================================

// --- Reverb 1
(
SynthDef(\rev1, {|mix=0.4, room=0.9, damp=0.1, amp=1, gate=1, out=0|
	var sen, env;
	sen = FreeVerb.ar(InFeedback.ar(9, 2), mix, room, damp, amp);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.1), gate, doneAction: 0);
	Out.ar(out, sen * env);
}).add
);

// --- Reverb 2
(
SynthDef(\rev2, {|mix=0.3, room=0.73, damp=0.9, amp=1, gate=1, out=0|
	var sen, env;
	sen = FreeVerb.ar(InFeedback.ar(11, 2), mix, room, damp, amp);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.1), gate, doneAction: 0);
	Out.ar(out, sen * env);
}).add
);

// --- lpf
(
SynthDef(\lpf, {|cfl = 100, gate = 1,  ol = 0|
	var lpf, env;
	lpf = LPF.ar(InFeedback.ar(13, 2), cfl, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction:0);
	Out.ar(ol, lpf * env);
}).add
);

// --- hpf
(
SynthDef(\hpf, {|cfh = 1000, gate = 1, oh = 0|
	var hpf, env;
	hpf = HPF.ar(InFeedback.ar(15, 2), cfh, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction:0);
	Out.ar(oh, hpf * env);
}).add
);

// --- bpf
(
SynthDef(\bpf, {|cfb = 1000, st=500, end=1000, dur=2, rq=1, gate = 1, ob = 0|
	var line, bpf, env;
	line = Line.kr(st, end, dur);
	bpf = BPF.ar(InFeedback.ar(17, 2), cfb, rq, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction:0);
	Out.ar(ob, bpf * env);
}).add
);

// --- Delay 1, mdt = maxdelayTime, dt = delayTime, dct = decayTime
(
SynthDef(\delay1, {|mdt = 0.3, dt = 0.2, dct = 8, od1=0|
var del = AllpassN.ar(InFeedback.ar(19, 2), mdt, dt, dct);
Out.ar(od1, del);
}).add
);

// --- Delay 2
(
SynthDef(\delay2, {|mdt = 0.3, dt = 0.2, dct = 2, od2 = 0|
var del;
del=CombL.ar(InFeedback.ar(21, 2), mdt, dt, dct);
Out.ar(od2, del);
}).add
);

//===============
// sintes nuevos
//===============

// --- psw
(
SynthDef(\psw, {|freq=300, puls=0.5, amp1=0.55, amp2=0.04, apsw=0.5, ppsw=0, atpsw=0.001, spsw=0.13, rpsw=0.2, opsw=0|
var sen1, sen2, sen3, paneo, env;
	sen1 = Pulse.ar(freq, puls, amp1);
	sen2 = SinOsc.ar(freq * 1.001, 0, 1);
	sen3 = WhiteNoise.ar(amp2);
	paneo = Pan2.ar((sen1 * sen2) + sen3, ppsw, apsw);
	env = EnvGen.kr(Env([0, 1, 1, 0], [atpsw, spsw, rpsw]), doneAction:2);
Out.ar(opsw, paneo * env);
}).add
);

(
SynthDef(\ohh, {|aohh=0.19, pohh=0, oohh=0, rohh=0.9|
	var sen, bpf, bpf2, bpf3, env;
	sen = WhiteNoise.ar(aohh);
	bpf = BPF.ar(sen, 400, 0.2);
	bpf2 = BPF.ar(sen, 800, 0.6);
	bpf3 = BPF.ar(sen, 3500, 0.6);
	sen = Pan2.ar(bpf + bpf2 + bpf3, pohh);
	env = EnvGen.kr(Env([0, 1, 0], [0.001, rohh], \cub), doneAction:2);
	Out.ar(oohh, (sen * env))
}).add
);

//=============
//otros
//=============

// --- wave shape
~b3.cheby(Array.series(8, 0.01, 0.03));

(
SynthDef(\ws, {|freq = 300, aws = 0.5, pws = 0, atws = 0.1, rws = 0.1, ows = 0|
	var sen, env;
	sen = Shaper.ar(~b3, SinOsc.ar(freq, 0, aws));
	sen = Pan2.ar(sen, pws);
	env = EnvGen.kr(Env.perc(atws, rws), doneAction:2);
	Out.ar(ows, sen * env);
}).add
);

);



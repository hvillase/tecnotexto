TecnoTexto {

	var <rev, <dly, <lpf, <hpf, <bpf;

	boot {arg scope = false, meter = false;
	this.synths;
		if(scope, {Server.local.scope});
		if(meter, {Server.local.meter});
		^"TecnoTexto";
	}

	synths {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/tecnotexto/sintes.scd").standardizePath);
		^"synths";
	}

	fx {arg o1=0, o2=0, o3=0, o4=0, o5=0, i1=9, i2=11, i3=13, i4=15, i5=17;
		rev=Synth(\rev1, [\in, i1, \out, o1]);
		dly=Synth(\delay1, [\in, i2,\out, o2]);
		lpf=Synth(\lpf, [\in, i3,\out, o3]);
		hpf=Synth(\hpf, [\in, i4,\out, o4]);
		bpf=Synth(\bpf, [\in, i5,\out, o5]);
		^"effects: on";
	}

	fxoff {
		rev.free; dly.free; lpf.free; hpf.free; bpf.free;
		^"effects: off"
	}

	test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\note, Pseq([0, 1, 2, 3, 4, 5, 6, 7, 8], inf),
			\out, Pseq([0, 1], 3)
		).play;
		^"testing";
	}

	tempo {arg tempo = 120/60;
		TempoClock.default.tempo_(tempo)
		^"TecnoTexto Tempo";
	}

}
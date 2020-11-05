TecnoTexto {

	classvar <rev1, <dly1, <lpf, <hpf, <bpf;

	*boot {arg scope = false, meter = false;
	this.synths;
		if(scope, {Server.local.scope});
		if(meter, {Server.local.meter});
		^"TecnoTexto";
	}

	*synths {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/tecnotexto/sintes.scd").standardizePath);
		^"synths";
	}

	*fx {arg o1=0,o2=0, o3=0, o4=0, o5=0;
		rev1 = Synth(\rev1, [\out, o1]);
		dly1 = Synth(\delay1, [\out, o2]);
		lpf = Synth(\lpf, [\out, o3]);
		hpf = Synth(\hpf, [\out, o4]);
		bpf = Synth(\bpf, [\o5, o5]);
		^"effects";
	}

	*test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\note, Pseq([0, 1, 2, 3, 4, 5, 6, 7, 8], inf),
			\out, Pseq([0, 1], 3)
		).play;
		^"testing";
	}

	*tempo {arg tempo = 120/60;
		TempoClock.default.tempo_(tempo)
		^"TecnoTexto Tempo";
	}

}
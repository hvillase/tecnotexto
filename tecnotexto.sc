TecnoTexto {

	classvar <rev1, <lpf, <hpf, <bpf, <dly1;

	*boot {arg scope = false, meter = false;
	this.waitForBoot;
		if(scope, {Server.local.scope});
		if(meter, {Server.local.meter});
		^"TecnoTexto";
	}

	*waitForBoot {
		this.synths;
		^"waiting";
	}

	*synths {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/tecnotexto/sintes.scd").standardizePath);
		^"synths";
	}

	*fx {
		rev1 = Synth(\rev1);
		lpf = Synth(\lpf);
		hpf = Synth(\hpf);
		bpf = Synth(\bpf);
		dly1 = Synth(\delay1);
		^"effects";
	}

	*test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\note, Pseq([0,1,2,3,4,5,6,7,8], inf),
			\out, Pseq([0, 1], 3)
		).play;
		^"testing";
	}

	*tempo {arg tempo = 120/60;
		TempoClock.default.tempo_(tempo)
		^"TecnoTexto Tempo";
	}

}
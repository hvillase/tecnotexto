TecnoTexto {

	var <rev1, <rev2, <lpf, <hpf, <bpf, <dly1, <dly2;

	boot {arg scope = false, meter = false;
	this.waitForBoot;
		if(scope, {Server.local.scope});
		if(meter, {Server.local.meter});
		^"Tecno Texto";
	}

	waitForBoot {
		this.sounds;
		fork{2.wait; this.synths};
	}

	sounds {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/tecnotexto/sonidos.scd").standardizePath);
		^"Sonidos Cargados";
	}

	synths {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/tecnotexto/sintes.scd").standardizePath);
		^"Sintes Cargados";
	}

	fx {
		rev1 = Synth(\rev1);
		rev2 = Synth(\rev2);
		lpf = Synth(\lpf);
		hpf = Synth(\hpf);
		bpf = Synth(\bpf);
		dly1 = Synth(\delay1);
		dly2 = Synth(\delay2);
		^"Efectos listos";
	}

	test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\note, Pseq([0,1,2,3,4,5,6,7,8], inf),
			\out, Pseq([0, 1], 3)
		).play;
		^"prueba";
	}


	tempo {arg tempo = 120/60;
		TempoClock.default.tempo_(tempo);
		^"Tempo listo";
	}

}
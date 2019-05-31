// se pueden correr muchas instancias
TecnoTexto {

	var <rev1; var <rev2; var <lpf; var <hpf; var <bpf; var <dly1; var <dly2;

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

	fx {// de instancia
		rev1 = Synth(\rev1);
		rev2 = Synth(\rev2);
		lpf = Synth(\lpf);
		hpf = Synth(\hpf);
		bpf = Synth(\bpf);
		dly1 = Synth(\delay1);
		dly2 = Synth(\delay2);
		^"Efectos Listos";
	}

	test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\out, Pseq([0, 1], 3)
		).play;
		^"Prueba";
	}


	tempo {arg tempo = 120/60;
		TempoClock.default.tempo_(tempo);
		^"Tempo Listo";
	}

}

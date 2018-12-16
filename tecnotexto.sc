TecnoTexto {

	*boot {arg scope=false, meter=false;
	TecnoTexto.waitForBoot;
		if(scope, {Server.local.scope});
		if(meter, {Server.local.meter});
	}

	*waitForBoot {
		TecnoTexto.synths;
		fork{1.wait};
	}

	*synths {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/hernani.sc/sintes.scd").standardizePath);
		^"sintes cargados";
	}

	*fx {
		~rev1 = Synth(\rev1);
		~rev2 = Synth(\rev2);
		~lpf = Synth(\lpf);
		~hpf = Synth(\hpf);
		~bpf = Synth(\bpf);
		~dly1 = Synth(\delay1);
		~dly2 = Synth(\delay2);
		^"efectos listos";
	}

	*test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\out, Pseq([0, 1], 3)
		).play;
		^"prueba";
	}

	
	*tempo {arg tempo=120/60;
		TempoClock.default.tempo_(tempo);
		^"tempo listo";
	}

}

// returns
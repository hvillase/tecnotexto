TecnoTexto {

	classvar <rev1, <rev2, <lpf, <hpf, <bpf, <dly1, <dly2, <soundDictionary;

	*boot {arg scope = false, meter = false;
	this.waitForBoot;
		if(scope, {Server.local.scope});
		if(meter, {Server.local.meter});
		^"TecnoTexto";
	}

	*waitForBoot {
		/*this.sounds;
		fork{2.5.wait; this.synths};
		*/
		this.synths;
		^"waiting";
	}
/*
	// Sample Texto
	*sounds {arg server;
		soundDictionary = Dictionary.new;
		soundDictionary.add(\snd -> PathName(Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/").entries.collect({
	arg sound; Buffer.read(server ? Server.default, sound.fullPath)}))
	}
*/
	*synths {
		thisProcess.interpreter.executeFile((Platform.userExtensionDir ++ "/tecnotexto/sintes.scd").standardizePath);
		^"Sintes Cargados";
	}

	*fx {
		rev1 = Synth(\rev1);
		//rev2 = Synth(\rev2);
		lpf = Synth(\lpf);
		hpf = Synth(\hpf);
		bpf = Synth(\bpf);
		dly1 = Synth(\delay1);
		//dly2 = Synth(\delay2);
		^"TecnoTexto Fx";
	}

	*test {
		Pbind(\instrument, \default,
			\dur, 0.5,
			\amp, 0.1,
			\note, Pseq([0,1,2,3,4,5,6,7,8], inf),
			\out, Pseq([0, 1], 3)
		).play;
		^"TecnoTexto Test";
	}

	*tempo {arg tempo = 120/60;
		TempoClock.default.tempo_(tempo)
		^"TecnoTexto Tempo";
	}

}
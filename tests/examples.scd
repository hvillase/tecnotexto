// TecnoTexto examples

//Server.local.options.device = "";
//Server.local.options.numOutputBusChannels = 4;

s.boot;
s.plotTree;

~x = TecnoTexto.new;
~x.boot; // turn on TecnoTexto
~x.fx; // turn on effects
~x.fxoff; // turn off effects
~x.rev.set(\mix, 0.4, \room, 0.4); // set values of reverb
//~x.dly.set(\dt, \dct);

Synth(\sine, [\o1, 9]); // try a sine synth with reverb
Synth(\sine, [\o1, 11]); // try a sine synth with delay

// second instance of TecnoTexto to add more effects: rev, delay, lpf, hpf and bpf

o = TecnoTexto.new;
o.boot;
o.fx(19, 21, 23, 25, 27, 0, 0, 0, 0, 0); // arguments 1 to 5 are differente inputs
o.fxoff;
o.rev.set(\mix, 0.5, \room, 0.9);

Synth(\saw, [\freq, 200, \r2, 1, \o2, 19]);


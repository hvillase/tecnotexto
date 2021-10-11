// TecnoTexto examples

//Server.local.options.device = "";
//Server.local.options.numOutputBusChannels = 4;

s.boot;
s.plotTree;

t = TecnoTexto.new;
t.boot; // turn on TecnoTexto
t.fx; // turn on effects
t.fxoff; // turn off effects
t.rev.set(\mix, 0.4, \room, 0.4); // set values of reverb

Synth(\sine, [\o1, 9]); // try a sine synth

// second instance of TecnoTexto to add more effects: rev, delay, lpf, hpf and bpf

o = TecnoTexto.new;
o.boot;
o.fx(19, 21, 23, 25, 27, 0, 0, 0, 0, 0); // arguments 1 to 5 are differente inputs
o.fxoff;
o.rev.set(\mix, 0.5, \room, 0.9);

Synth(\saw, [\freq, 200, \r2, 1, \o2, 19]);


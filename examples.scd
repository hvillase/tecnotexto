// TecnoTexto examples

//Server.local.options.device = "";
//Server.local.options.numOutputBusChannels = 4;

s.boot;
s.plotTree;

t=TecnoTexto.new;
t.boot;
t.fx;
t.fxoff; // to quit effects
t.rev.set(\mix, 0.4, \room, 0.4)

Synth(\sine, [\o1, 9]);

// a second version of TecnoTexto to add more effects: rev, delay, lpf, hpf and bpf
o=TecnoTexto.new;
o.boot;
o.fx(19, 21, 23, 25, 27, 0, 0, 0, 0, 0); // arguments 1 to 5 are differente outputs
o.fxoff;
o.rev.set(\mix, 0.5, \room, 0.9);

Synth(\saw, [\freq, 200, \r2, 1, \o2, 21]);


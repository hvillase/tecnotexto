// TecnoTexto examples

//Server.local.options.device = "";
//Server.local.options.numOutputBusChannels = 4;

s.boot;
s.plotTree;

t=TecnoTexto.new;
t.boot;
t.fx;
t.rev.set(\mix, 0.4, \room, 0.2)

Synth(\sine, [\o1, 9]);

// a second version of TecnoTexto
o=TecnoTexto.new;
o.boot;
o.fx(0, 0, 0, 0, 0, 19, 21, 23, 25, 27); // arguments 6 to 10 are differente outputs
o.rev.set(\mix, 0.5, \room, 0.9);

Synth(\saw, [\o2, 19]);


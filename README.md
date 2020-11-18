# TecnoTexto
Una Clase de SuperCollider para llamar tus SynthDefs y efectos.

## TecnoTexto
La clase llama un documento con 5 formas básicas y 5 efectos organizados en SynthDefs: sine, saw, tri, pulse, white noise y silence; además reverb, delay, lpf, hpf y bpf. Los SynthDefs se encuentran en un documento con extensión -scd; este documento puede ser modificado para añadir otros sintetizadores y efectos.

## Sintes
El documento sintes.scd contiene los SynthDefs de formas de onda y efectos. Todos están encpasulados entre un par de paréntesis generales para que sean leídos de manera correcta. Este documento puede ser modificado al añadir otros instrumentos y efectos.

## Ejemplo

```
s.boot
t = TecnoTexto.new;
t.boot;
t.fx;
t.fxoff; // apaga los efectos

Synth(\sine); // Onda sinoidal con valores predeterminados

Synth(\sine, [\r1, 2]); // Modificando su relajamiento

Synth(\sine, [\o1, 9]); // Salida por reverb
```

## Mapeo y nemotecnia

El orden de los sintetizadores es el siguiente: sine, saw, lftri, pulse, wnoise y silence.
Los valores de sine, que es el primero, comienzan con la primer letra del parámetro sonoro seguido del número de la posición que ocupa ese sonido, en el caso de sine es 1. Por ejemplo la llave de amplitud se construye con la 'a' y el 1 resultando \a1, esto permite teclear solo dos caracteres en el live coding y asociar el númeero uno con sine. La frecuencia permanece con la llave predeterminada de \freq para utilizar las llaves alturas como \note, \midinote etc.

\sine = sine, \freq = frequency, \pi1 = phase, \a1 = amplitude, \p1 = pan, \at1 = attack, \r1 = release, \o1 = out

```
Synth(\sine, [\freq, 440, \pi1 = 0, \a1, 0.7, \p1, 0.5, \at, 0.9, \r1, 2.5, \o1, 0]);
```

## Efectos

```
Synth(\sine, [\freq, 440, \pi1, 0, \a1, 0.7, \p1, 0.5, \at, 0.9, \r1, 1.5, \o1, 9]); // salida \o1 por 9 = reverb
Synth(\sine, [\freq, 440, \pi1, 0, \a1, 0.7, \p1, -0.5, \at, 0.9, \r1, 0.5, \o1, 11]); // salida \o1 por 11 = delay

t.dly.set(\dt, 0.5, \dct, 4); // cambiando tiempo de delay \dt a medio segundo y decaimiento de delay \dct a 4 segundos

Synth(\sine, [\freq, 400, \a1, 0.6, \p1, 0, \at, 0.1, \r1, 0.5, \o1, 11]); // nuevo tiempo de decaimiento en delay
```

## Patrones

```
// tecnotexto

t.dly.set(\dt, 0.125, \dct, 1.75);

(
Pdef(\kl, Pbind(\instrument, Pseq([\saw, Pn(\pulse, 2), \lftri], inf),
	\note, Pseq([0, 2, 3, Pn(2, 2), 5, 2, 7, Pstutter(2, Pseq([0, 3, 9], 1)), Prand([0, 12], 2)], inf),
	\octave, Pseq([3, 4, Pn(5, 2), 4, Pn(3, 2)], inf),
	\a1, Pseq([0.2, 0, 0.2, 0.3, Pseq([0.4, 0.2], 3)].mirror, inf),
	\a4, Pkey(\a1, inf) * 0.5,
	\a3, Pkey(\a1, inf) * 1.2,
	\p1, 0.2,
	\p4, -0.2,
	\r4, Pseq([0.2, 0.1, Pn(0.5, 2)], inf),
	\dur, Pseq([1/8], inf),
	\o2, 9,
	\o3, 11,
	\o4, Pseq([Pn(11, 2), 9, 0], inf)
)).play
)
```
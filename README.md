# TecnoTexto
Una Clase de SuperCollider para llamar tus SynthDefs.

## TecnoTexto
La clase llama un documento con 5 formas básicas y 5 efectos organizados en SynthDefs: sine, saw, tri, pulse, white noise y silence; además reverb, delay, lpf, hpf y bpf. Los SynthDefs se encuentran en un documento con extensión -scd; este documento puede ser modificado para añadir otros sintetizadores y efectos.

## Sintes
El documento sintes.scd contiene los SynthDefs de frmas de onda y efectos. Todos están encpasulados entre un par de paréntesis generales para que sean leídos de manera correcta. Este documento puede ser modificado al añador otros instrumentos y efectos.

## Ejemplo

s.boot
t = TecnoTexto;
t.boot;
t.fx;

Synth(\sine); // Onda sinoidal con valores predeterminados

Synth(\sine, [\r1, 2]); // Modificando su relajamiento

## Mapeo y nemotecnia

El orden de los sintetizadores es el siguiente: sine, saw, lftri, pulse, wnoise y silence.
Los valores de sine, que es el primero, comienzan con la primer letra del parámetro sonoro seguido del número de la posición que ocupa ese sonido, en el caso de sine es 1. Por ejemplo la llave de amplitud se construye con la 'a' y el 1 resultando \a1, esto permite teclear solo dos caracteres en el live coding y asociar el númeero uno con sine. La frecuencia permanece con la llave predeterminada de \freq para utilizar las llaves alturas como \note, \midinote etc.

\sine = sine, \freq = frequency, \pi1 = phase, \a1 = amplitude, \p1 = pan, \at1 = attack, \r1 = release, \o1 = out

Synth(\sine, [\freq, 440, \pi1 = 0, \a1, 0.7, \p1, 0.5, \at, 0.9, \r1, 2.5, \o1, 0]);

## Efectos

## Patrones
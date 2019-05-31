// Lectura de buffers y sampleos

// 808 sounds de mi caja de ritmos ==================================================
// 44100

(
~sd808 = Buffer.read(s, Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/sd808.wav");
~bd808 = Buffer.read(s, Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/bd808.wav");
~bd2808 = Buffer.read(s, Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/bd2808.wav");
~hh808 = Buffer.read(s, Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/hh808.wav");
~ohh808 = Buffer.read(s, Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/ohh808.wav");
);

// otros sampleos

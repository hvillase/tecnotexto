// Lectura sampleos

// 808 sounds
// 44100 khz, usar BufSampleRate

// Dictionary
(
~s808 = Dictionary.new;
~s808.add(\o -> PathName(Platform.userExtensionDir +/+ "/tecnotexto/sonidos808/").entries.collect({
	arg sonido;
	Buffer.read(s, sonido.fullPath);
})
)
);
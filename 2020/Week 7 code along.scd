s.boot

// working with audio:

~clap = Buffer.read(s, "Documents/lmms/samples/LazerBlade sample collection/House/Percussions/House Percussion 01.wav")

~snap = Buffer.read(s, "/Documents/lmms/samples/LazerBlade sample collection/House/Percussions/House Snap 02.wav")


~clap.play;
~snap.play;

~clap.numChannels;

~clap.duration; // seconds

~clap.numFrames; // samples (simultaneous across channels)

~clap.sampleRate; // server is running at one sample rate, audio files have sample rates, buffer and hardware have sample rates too.

~clap.bufnum
~snap.bufnum

Buffer.freeAll

// reading audio files in this fashion won't be compatible across different OS's or machines - the file paths would be different.




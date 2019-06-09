(
FoxDot.start;

s.boot;

// define the OSC function inside the main enviroment
~oscFunc = OSCFunc({
	|msg, time, addr, recvPort|
	var data_analyzer = NetAddr("localhost", 7089);
	var data;

	data = msg[3..14];
	data_analyzer.sendMsg("/scdata",
		"/loud", data[0],
		"/flat",data[1],
		"/centroid", data[2],
		"/eqm", data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10])
},'/tr');

Task ({
	SynthDef(\audioAnalyzer, {
		| in=0, rate1=1, rate2=1 |
		var sig, fft;//, amplitude;
		var loud, powers, flat, centroid;
		var freq, hasFreq;
		var ph, onset;

		// we must use a mono source
		sig = Mix.ar(In.ar(in, 2));

		//amplitude = Amplitude.kr(sig);
		fft = FFT(LocalBuf(2048), sig);
		loud = Loudness.kr(fft);
		powers = FFTSubbandPower.kr(fft, [100, 200, 400, 800, 1600, 3200, 6400], 1, 2);
		powers = (powers.log10 * 0.25).max(0.0);

		flat = SpecFlatness.kr(fft);
		centroid = SpecCentroid.kr(fft);

		SendReply.kr(Impulse.kr(rate1),'/tr', [loud, flat, centroid] ++ powers, replyID: 1);
	}).add;

	3.wait;

	// and instantiate it just after the default server group
	~listenSynth = Synth(\audioAnalyzer, [\in, 0,\rate1, 10, \rate2, 10],target:Server.default.defaultGroup, addAction:\addAfter);
}).start;


//start proxyspace
p = ProxySpace.push(s);
//start tempo clock
p.makeTempoClock;
//give proxyspace a tempo
p.clock.tempo = 2;
)

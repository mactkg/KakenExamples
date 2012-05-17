minim.getInputStreamが使えるかも
```Java
/**
 * Get the input as an AudioStream that you can read from yourself, rather
 * than wrapped in an AudioInput that does that work for you.
 * 
 * @param type
 *            Minim.MONO or Minim.STEREO
 * @param bufferSize
 *            how long you want the <code>AudioInput</code>'s sample buffer
 *            to be
 * @param sampleRate
 *            the desired sample rate in Hertz (typically 44100)
 * @param bitDepth
 *            the desired bit depth (typically 16)
 * @return an AudioStream that reads from the input source of the soundcard.
 */
public AudioStream getInputStream(int type, int bufferSize, float sampleRate, int bitDepth)
{
  AudioStream stream = mimp.getAudioInput( type, bufferSize, sampleRate, bitDepth );
  streams.add( stream );
  return stream;
}
```
buffersize:512
sampleRate:10kHz*2 -> 20kHz?
bitDepth:none

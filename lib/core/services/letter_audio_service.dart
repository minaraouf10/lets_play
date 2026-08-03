import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';

/// Speaks Arabic letters aloud for the quiz screens.
///
/// Uses on-device text-to-speech so every letter works without shipping an
/// audio file per lesson. [speak] uses the normal rate; [speakSlowly] backs
/// the "snail" button.
///
/// Android 11+ additionally needs the `TTS_SERVICE` entry in
/// `<queries>` (see AndroidManifest.xml) or the engine stays invisible.
@lazySingleton
class LetterAudioService {
  LetterAudioService(this._tts);

  final FlutterTts _tts;

  static const double _normalRate = 0.45;
  static const double _slowRate = 0.2;
  static const String _arabic = 'ar';

  bool _configured = false;

  /// True once configuration found a usable Arabic voice. When false the
  /// device has no Arabic TTS data installed and nothing will be spoken.
  bool get isArabicAvailable => _isArabicAvailable;
  bool _isArabicAvailable = false;

  Future<void> _ensureConfigured() async {
    if (_configured) return;
    _configured = true;

    try {
      // On Android this reports whether the language *and* its voice data are
      // actually installed; a missing voice is the usual cause of silence.
      final available = await _tts.isLanguageAvailable(_arabic);
      _isArabicAvailable = available == true;

      if (_isArabicAvailable) {
        await _tts.setLanguage(_arabic);
      } else {
        debugPrint(
          'LetterAudioService: no Arabic TTS voice installed. '
          'Install one via Settings > Accessibility > Text-to-speech.',
        );
      }

      await _tts.setVolume(1);
      await _tts.setPitch(1);
      await _tts.awaitSpeakCompletion(true);
    } catch (e) {
      debugPrint('LetterAudioService: TTS init failed: $e');
    }
  }

  Future<void> speak(String text) => _say(text, _normalRate);

  Future<void> speakSlowly(String text) => _say(text, _slowRate);

  Future<void> _say(String text, double rate) async {
    if (text.isEmpty) return;
    await _ensureConfigured();
    try {
      await _tts.stop();
      await _tts.setSpeechRate(rate);
      await _tts.speak(text);
    } catch (e) {
      debugPrint('LetterAudioService: speak("$text") failed: $e');
    }
  }

  Future<void> stop() => _tts.stop();
}

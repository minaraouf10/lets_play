import '../../../../core/utils/app_imports.dart';


/// Plays the animated LEGO build-up. Flutter decodes and animates
/// multi-frame GIFs natively via [Image] — no extra package needed.
class SplashGifView extends StatelessWidget {
  const SplashGifView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox.expand(
        child: Image.asset(
          AppAssets.splashGif,
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ),
      ),
    );
  }
}

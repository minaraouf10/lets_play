import '../../../../../core/utils/app_imports.dart';
import '../../data/datasources/letter_names_data.dart';


/// Celebration screen shown after a lesson is completed and before the
/// fill-in-the-blanks quiz starts.
///
/// Flow: LessonIntro → LetterGame → **GreatJobPage** → (next game / quiz)
class GreatJobPage extends StatefulWidget {
  const GreatJobPage({
    super.key,
    required this.lessonId,
    required this.userName,
    this.levelType = LevelType.letters,
    this.nextRouteName,
  });

  final String lessonId;
  final String userName;

  /// Tints the background to match the level the lesson belongs to.
  final LevelType levelType;

  /// Where CONTINUE goes. Defaults to the letter review flow; the trace
  /// screen passes the levels map so the lesson ends there instead of
  /// looping back through the review.
  final String? nextRouteName;

  @override
  State<GreatJobPage> createState() => _GreatJobPageState();
}

class _GreatJobPageState extends State<GreatJobPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: widget.levelType.celebrationGradient),
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar with close button ──────────────────────────────
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.spaceSm,
                    top: AppDimensions.spaceSm,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.ink),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),

              // ── Heading text ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceLg,
                ),
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Column(
                      children: [
                        Text(
                          'Great Job ${widget.userName}!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceSm),
                        const Text(
                          "now let's test you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Character illustration ─────────────────────────────────
              Expanded(
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceLg,
                    ),
                    child: Image.asset(
                      AppAssets.greatJobCharacter,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // ── CONTINUE button ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.spaceLg,
                  AppDimensions.spaceLg,
                  AppDimensions.spaceLg,
                  AppDimensions.spaceLg,
                ),
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeight,
                    child: OutlinedButton(
                      onPressed: () {
                        final next =
                            widget.nextRouteName ?? AppRoutes.letterReviewName;
                        context.pushReplacementNamed(
                          next,
                          queryParameters: next == AppRoutes.levelsName
                              ? const {}
                              : {
                                  'lessonId': widget.lessonId,
                                  'letterName':
                                      displayLetterNameFor(widget.lessonId),
                                },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.background,
                        side: const BorderSide(
                          color: AppColors.ink,
                          width: AppDimensions.neoBorderWidth,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMd,
                          ),
                        ),
                      ),
                      child: const Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

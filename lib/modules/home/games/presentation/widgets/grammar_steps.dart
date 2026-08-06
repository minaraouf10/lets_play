import '../../../../../core/utils/app_imports.dart';
import '../../domain/entities/grammar_lesson.dart';
import 'word_speaker_button.dart';

/// The blue neo-brutalist banner every grammar reference card sits under.
class GrammarBanner extends StatelessWidget {
  const GrammarBanner({
    super.key,
    required this.arabic,
    required this.english,
  });

  final String arabic;
  final String english;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.grammarBanner,
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidth,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(
              AppDimensions.neoShadowOffset,
              AppDimensions.neoShadowOffset,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            arabic,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.textOnColor,
            ),
          ),
          Text(
            english,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// An Arabic term over its English gloss in parentheses.
class _TermText extends StatelessWidget {
  const _TermText({required this.term});

  final GrammarTerm term;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          term.arabic,
          textDirection: TextDirection.rtl,
          style: AppTextStyles.headingMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        if (term.english != null)
          Text(
            '(${term.english})',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.grammarGloss,
            ),
          ),
      ],
    );
  }
}

/// A reference card: banner over "X = Y" rows, with an optional speaker on
/// each row. Backs the word-type, verb-type, imperative and past-sign cards.
class GrammarEquationCardStep extends StatelessWidget {
  const GrammarEquationCardStep({
    super.key,
    required this.card,
    required this.audioUnavailable,
    required this.onSpeak,
  });

  final GrammarEquationCard card;
  final bool audioUnavailable;
  final ValueChanged<String> onSpeak;

  @override
  Widget build(BuildContext context) {
    final hasSpeakers = card.rows.any((r) => r.spoken != null);

    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSm),
        Text(card.heading, style: AppTextStyles.bodyLarge),
        const SizedBox(height: AppDimensions.spaceLg),
        GrammarBanner(arabic: card.title, english: card.titleEn),
        const SizedBox(height: AppDimensions.spaceLg),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          decoration: BoxDecoration(
            color: AppColors.grammarPanel,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: Column(
            children: [
              for (final row in card.rows)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spaceSm,
                  ),
                  // Laid out right-to-left so the type sits on the right,
                  // matching how the card reads in Arabic.
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(child: Center(child: _TermText(term: row.type))),
                      Text('=', style: AppTextStyles.headingMedium),
                      Expanded(
                        child: Center(child: _TermText(term: row.example)),
                      ),
                      // Reserve the speaker column on every row so the "="
                      // signs stay aligned when only some rows speak.
                      if (hasSpeakers)
                        SizedBox(
                          width: AppDimensions.wordCardSpeakerSize,
                          child: row.spoken == null
                              ? null
                              : WordSpeakerButton(
                                  onPressed: () => onSpeak(row.spoken!),
                                  size: AppDimensions.wordCardSpeakerSize,
                                ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (audioUnavailable && hasSpeakers) ...[
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}

/// A reference card whose body is a grid of terms — the noun types and the
/// noun-sign tiles. Nothing to answer.
class GrammarTermsCardStep extends StatelessWidget {
  const GrammarTermsCardStep({super.key, required this.card});

  final GrammarTermsCard card;

  @override
  Widget build(BuildContext context) {
    // The sign tiles are bare glyphs on their own chips; the noun types are
    // labelled pairs laid out on one shared panel.
    final isTileGrid = card.terms.every((t) => t.english == null);

    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSm),
        Text(card.heading, style: AppTextStyles.bodyLarge),
        const SizedBox(height: AppDimensions.spaceLg),
        GrammarBanner(arabic: card.title, english: card.titleEn),
        const SizedBox(height: AppDimensions.spaceLg),
        if (isTileGrid)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppDimensions.spaceMd,
            runSpacing: AppDimensions.spaceMd,
            children: [
              for (final term in card.terms)
                Container(
                  width: AppDimensions.grammarSignTileSize,
                  height: AppDimensions.grammarSignTileSize,
                  decoration: BoxDecoration(
                    color: AppColors.grammarPanel,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(
                      color: AppColors.border,
                      width: AppDimensions.borderWidth,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      term.arabic,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.headingMedium,
                    ),
                  ),
                ),
            ],
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            decoration: BoxDecoration(
              color: AppColors.grammarPanel,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: GridView.count(
              crossAxisCount: card.columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppDimensions.spaceMd,
              crossAxisSpacing: AppDimensions.spaceMd,
              childAspectRatio: AppDimensions.grammarTypeAspectRatio,
              // Right-to-left so "إنسان" leads, as on the reference card.
              children: [
                for (final term in card.terms)
                  Center(child: _TermText(term: term)),
              ].reversed.toList(),
            ),
          ),
      ],
    );
  }
}

/// A word on a pink card with a claim about it — answer True or False.
class GrammarStatementStep extends StatelessWidget {
  const GrammarStatementStep({
    super.key,
    required this.data,
    required this.answer,
    required this.onAnswer,
  });

  final GrammarStatementStepData data;
  final bool? answer;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSm),
        Text(data.heading, style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceLg),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.accentPink,
              border: Border.all(
                color: AppColors.ink,
                width: AppDimensions.neoBorderWidth,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.ink,
                  offset: Offset(
                    AppDimensions.neoShadowOffset,
                    AppDimensions.neoShadowOffset,
                  ),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.word,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      // Longer phrases need a smaller glyph to fit the card.
                      fontSize: data.subtitle == null
                          ? AppDimensions.grammarStatementGlyphSize
                          : AppDimensions.grammarStatementPhraseSize,
                      color: AppColors.textOnColor,
                    ),
                  ),
                  if (data.subtitle != null) ...[
                    const SizedBox(height: AppDimensions.spaceMd),
                    Text(
                      data.subtitle!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        Row(
          children: [
            Expanded(
              child: _TrueFalseButton(
                label: 'True',
                isSelected: answer == true,
                isRight: data.isTrue,
                onPressed: () => onAnswer(true),
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: _TrueFalseButton(
                label: 'False',
                isSelected: answer == false,
                isRight: !data.isTrue,
                onPressed: () => onAnswer(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrueFalseButton extends StatelessWidget {
  const _TrueFalseButton({
    required this.label,
    required this.isSelected,
    required this.isRight,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final bool isRight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isRight
            ? AppColors.success
            : AppColors.error;

    return SizedBox(
      height: AppDimensions.optionRowHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.grammarPanel,
          side: BorderSide(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

/// Fill in the blank: a sentence with a gap, and two verbs to choose between.
class GrammarFillBlankStep extends StatelessWidget {
  const GrammarFillBlankStep({
    super.key,
    required this.data,
    required this.selectedId,
    required this.onSelect,
  });

  final GrammarFillBlankStepData data;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSm),
        Text(data.heading, style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        // The sentence reads right-to-left with a dashed gap in the middle.
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.before,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.headingMedium,
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Text(
              '_________',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Text(
              data.after,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.headingMedium,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceXxl),
        for (final option in data.options) ...[
          _WideChoiceTile(
            term: option,
            isSelected: option.id == selectedId,
            isCorrect: option.id == data.correctId,
            onTap: () => onSelect(option.id),
          ),
          const SizedBox(height: AppDimensions.spaceMd),
        ],
      ],
    );
  }
}

/// A word on a blue banner over wide category tiles: is this verb past,
/// present or imperative?
class GrammarCategoryStep extends StatelessWidget {
  const GrammarCategoryStep({
    super.key,
    required this.data,
    required this.selectedId,
    required this.onSelect,
  });

  final GrammarCategoryStepData data;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSm),
        Text(data.heading, style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceLg),
        Container(
          width: double.infinity,
          height: AppDimensions.grammarCategoryBannerHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.grammarBanner,
            border: Border.all(
              color: AppColors.ink,
              width: AppDimensions.neoBorderWidth,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(
                  AppDimensions.neoShadowOffset,
                  AppDimensions.neoShadowOffset,
                ),
              ),
            ],
          ),
          child: Text(
            data.word,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: AppDimensions.grammarCategoryGlyphSize,
              color: AppColors.textOnColor,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        for (final option in data.options) ...[
          _WideChoiceTile(
            term: option,
            isSelected: option.id == selectedId,
            isCorrect: option.id == data.correctId,
            onTap: () => onSelect(option.id),
          ),
          const SizedBox(height: AppDimensions.spaceMd),
        ],
      ],
    );
  }
}

/// A full-width answer row, used by the fill-in-the-blank screens.
class _WideChoiceTile extends StatelessWidget {
  const _WideChoiceTile({
    required this.term,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final GrammarTerm term;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppDimensions.optionRowHeight,
        decoration: BoxDecoration(
          color: AppColors.grammarPanel,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            term.arabic,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.headingMedium,
          ),
        ),
      ),
    );
  }
}

/// Screens 4 and 6: pick the right word from a grid of tiles.
class GrammarChoiceStep extends StatelessWidget {
  const GrammarChoiceStep({
    super.key,
    required this.choice,
    required this.selectedId,
    required this.onSelect,
  });

  final GrammarChoice choice;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text(
          choice.prompt,
          textAlign: TextAlign.center,
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        GridView.count(
          crossAxisCount: choice.columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppDimensions.spaceMd,
          crossAxisSpacing: AppDimensions.spaceMd,
          childAspectRatio: AppDimensions.grammarTileAspectRatio,
          children: [
            for (final option in choice.options)
              _ChoiceTile(
                term: option,
                isSelected: option.id == selectedId,
                isCorrect: option.id == choice.correctId,
                onTap: () => onSelect(option.id),
              ),
          ].reversed.toList(),
        ),
      ],
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.term,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final GrammarTerm term;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grammarPanel,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
        ),
        child: Center(child: _TermText(term: term)),
      ),
    );
  }
}

/// Screen 7: hear a word, then pick the picture that matches it.
class GrammarPictureStep extends StatelessWidget {
  const GrammarPictureStep({
    super.key,
    required this.question,
    required this.selectedId,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onSelect,
  });

  final GrammarPictureQuestion question;
  final String? selectedId;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceSm),
        Text('Choose the correct answer', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceLg),
        Container(
          width: double.infinity,
          height: AppDimensions.grammarWordBannerHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.grammarBanner,
            border: Border.all(
              color: AppColors.ink,
              width: AppDimensions.neoBorderWidth,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(
                  AppDimensions.neoShadowOffset,
                  AppDimensions.neoShadowOffset,
                ),
              ),
            ],
          ),
          child: Text(
            question.word,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.textOnColor,
              fontSize: AppDimensions.grammarWordGlyphSize,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        WordSpeakerButton(onPressed: onPlay),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppDimensions.spaceLg),
        Row(
          children: [
            for (final option in question.options) ...[
              Expanded(
                child: _PictureTile(
                  option: option,
                  isSelected: option.id == selectedId,
                  isCorrect: option.id == question.correctId,
                  onTap: () => onSelect(option.id),
                ),
              ),
              if (option != question.options.last)
                const SizedBox(width: AppDimensions.spaceMd),
            ],
          ],
        ),
      ],
    );
  }
}

class _PictureTile extends StatelessWidget {
  const _PictureTile({
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final GrammarPictureOption option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        label: option.label,
        button: true,
        child: Container(
          height: AppDimensions.wordImageCardHeight,
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          decoration: BoxDecoration(
            color: AppColors.grammarPanel,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(
              color: borderColor,
              width: isSelected
                  ? AppDimensions.neoBorderWidth
                  : AppDimensions.borderWidth,
            ),
          ),
          child: SvgPicture.asset(option.asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

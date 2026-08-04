import '../../../../core/utils/app_imports.dart';
import '../widgets/widgets_barrel.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedbackCubit>(),
      child: const _FeedbackView(),
    );
  }
}

class _FeedbackView extends StatelessWidget {
  const _FeedbackView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<FeedbackCubit, FeedbackState>(
          builder: (context, state) {
            final cubit = context.read<FeedbackCubit>();
            return Column(
              children: [
                ProfileHeader(
                  'Feedback',
                  trailing: IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: () async {
                      await cubit.send();
                      if (context.mounted && state.status == FeedbackStatus.sent) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent')),
                        );
                        context.pop();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                    child: Column(
                      children: [
                        const SizedBox(height: AppDimensions.spaceMd),
                        FeedbackRecipientRow(
                          label: 'To',
                          value: state.draft.to,
                          onChanged: cubit.updateTo,
                        ),
                        FeedbackRecipientRow(
                          label: 'Cc,Bcc,From',
                          value: state.draft.ccBcc,
                          onChanged: cubit.updateCcBcc,
                        ),
                        FeedbackRecipientRow(
                          label: 'Subject',
                          value: state.draft.subject,
                          onChanged: cubit.updateSubject,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        FeedbackBodyField(
                          value: state.draft.body,
                          onChanged: cubit.updateBody,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Thanks!',
                            style: AppTextStyles.feedbackThanks,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import '../../../../core/utils/app_imports.dart';
import '../widgets/widgets_barrel.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HelpCenterCubit>()..load(),
      child: const _HelpCenterView(),
    );
  }
}

class _HelpCenterView extends StatelessWidget {
  const _HelpCenterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HelpCenterCubit, HelpCenterState>(
          builder: (context, state) {
            final cubit = context.read<HelpCenterCubit>();
            if (state.status == HelpCenterStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == HelpCenterStatus.error) {
              return Center(child: Text(state.errorMessage ?? 'Error loading help topics'));
            }
            return Column(
              children: [
                const ProfileHeader('Help Center'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                  child: AppSearchField(onChanged: cubit.search),
                ),
                const SizedBox(height: AppDimensions.spaceMd),
                Expanded(
                  child: HelpTopicsList(
                    topics: state.visibleTopics,
                    expandedId: state.expandedId,
                    onToggle: cubit.toggleTopic,
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

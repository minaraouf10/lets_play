part of 'followers_cubit.dart';

enum FollowersStatus { initial, loading, loaded, error }

class FollowersState {
  const FollowersState({
    this.status = FollowersStatus.initial,
    this.followers = const [],
    this.query = '',
    this.selectedFollower,
    this.errorMessage,
  });

  final FollowersStatus status;
  final List<FollowerEntry> followers;
  final String query;
  final FollowerEntry? selectedFollower;
  final String? errorMessage;

  List<FollowerEntry> get visibleFollowers => followers
      .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  FollowersState copyWith({
    FollowersStatus? status,
    List<FollowerEntry>? followers,
    String? query,
    FollowerEntry? selectedFollower,
    String? errorMessage,
    bool clearSelection = false,
  }) =>
      FollowersState(
        status: status ?? this.status,
        followers: followers ?? this.followers,
        query: query ?? this.query,
        selectedFollower: clearSelection ? null : (selectedFollower ?? this.selectedFollower),
        errorMessage: errorMessage,
      );
}

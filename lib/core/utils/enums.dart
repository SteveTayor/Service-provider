

enum LoadState {loading,idle,success,error,loadmore,done}
enum HomeSessionState { logout, initial }
enum OverLayType { loader, message, none }
enum MessageType { error, success }

extension LoadExtension on LoadState {
  bool get isLoading => this == LoadState.loading;
  bool get isLoaded => this == LoadState.success;
  bool get isError => this == LoadState.error;
  bool get isInitial => this == LoadState.idle;
  bool get isLoadMore => this == LoadState.loadmore;
  bool get isCompleted => this == LoadState.done;
}

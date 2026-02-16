sealed class BootstrapState {
  const BootstrapState();
}

final class BootstrapInitialState extends BootstrapState {
  const BootstrapInitialState();
}

final class BootstrapLoadingState extends BootstrapState {
  const BootstrapLoadingState();
}

final class UserAuthenticatedState extends BootstrapState {
  const UserAuthenticatedState();
}

final class UserOnboardedState extends BootstrapState {
  const UserOnboardedState();
}

final class UserDidNotOnboardState extends BootstrapState {
  const UserDidNotOnboardState();
}

final class UserUnauthenticatedState extends BootstrapState {
  const UserUnauthenticatedState();
}

final class BootstrapErrorState extends BootstrapState {
  final Object? error;

  const BootstrapErrorState(this.error);
}

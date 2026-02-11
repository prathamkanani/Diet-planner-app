import '../../domain/repository/bootstrap_repository.dart';
import '../source/bootstrap_source.dart';

class BootstrapRepositoryImpl implements BootstrapRepository {
  final BootstrapSource source;

  const BootstrapRepositoryImpl(this.source);

  @override
  bool isUserAuthenticated() {
    return source.isUserAuthenticated();
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return await source.isOnboardingCompleted();
  }
}
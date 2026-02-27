import '../../domain/repository/bootstrap_repository.dart';
import '../source/bootstrap_source.dart';

class BootstrapRepositoryImpl implements BootstrapRepository {
  final BootstrapSource source;

  const BootstrapRepositoryImpl(this.source);

  @override
  bool fetchAuthStatus() {
    return source.fetchAuthStatus();
  }

  @override
  Future<bool> fetchOnboardingStatus() async {
    return await source.fetchOnboardingStatus();
  }
}
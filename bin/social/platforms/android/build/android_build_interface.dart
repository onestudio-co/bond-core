abstract class AndroidBuildInterface {
  Future<bool> build();

  Future<void> prepareEnv();
}

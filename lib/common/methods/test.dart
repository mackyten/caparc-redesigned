class TestMethods {
  Stream testOne() async* {
    try {
      yield (true);
    } catch (e) {
      yield (e);
    }
  }
}

class SessionController {
  //named constructor
  SessionController._internal();
  static final SessionController _session = SessionController._internal();
  String? userId;
//   factory: A special type of constructor in Dart that allows more control over instance creation.
// In this case, every time you try to create a new instance of SessionController, it will always return the
//  same _session instance. This ensures that only one instance of SessionController exists in the entire app.
//  Factory Constructor
// The factory keyword in Dart is used to define a factory constructor. Unlike regular constructors, a
// factory constructor:
// Can return an existing instance instead of creating a new one.
// Has more control over the creation process and can decide when and how to create instances.

  factory SessionController() {
    return _session;
  }
}

/// A [Error] object contains the title and message of an error.
class UserError {
  const UserError({
    required this.title,
    required this.message,
  });
  final String title;
  final String message;
}

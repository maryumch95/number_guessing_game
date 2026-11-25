
class Guess {
  final int? id;
  final int number;
  final String result;

  Guess({
    this.id,
    required this.number,
    required this.result,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'result': result,
    };
  }
}

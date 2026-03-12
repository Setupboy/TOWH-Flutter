class GamePlayer {
  const GamePlayer({
    required this.id,
    required this.name,
    required this.answer,
    required this.selectedColor,
    required this.voteAnswer,
  });

  final String id;
  final String name;
  final String answer;
  final String selectedColor;
  final String voteAnswer;

  GamePlayer copyWith({
    String? id,
    String? name,
    String? answer,
    String? selectedColor,
    String? voteAnswer,
  }) {
    return GamePlayer(
      id: id ?? this.id,
      name: name ?? this.name,
      answer: answer ?? this.answer,
      selectedColor: selectedColor ?? this.selectedColor,
      voteAnswer: voteAnswer ?? this.voteAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'answer': answer,
      'selectedColor': selectedColor,
      'voteAnswer': voteAnswer,
    };
  }

  factory GamePlayer.fromMap(Map<String, dynamic> map) {
    return GamePlayer(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      answer: map['answer'] as String? ?? '',
      selectedColor: map['selectedColor'] as String? ?? '',
      voteAnswer: map['voteAnswer'] as String? ?? '',
    );
  }
}

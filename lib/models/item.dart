class Item {
  final int? id;
  final String title;
  bool isDone;

  Item({this.id, required this.title, this.isDone = false});

  void toggleStatus() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, title: $title, isDone: $isDone}';
  }
}

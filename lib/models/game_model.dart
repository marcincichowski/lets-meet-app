
class Game {
  int id;
  int status;
  String name;
  String addDate;
  String acceptDate;
  String lastUpdateDate;
  int acceptedById;
  int requestedById;
  String url;
  String description;
  int personCount;
  bool isOnline;

  Game({
    required this.id,
    required this.status,
    required this.name,
    required this.addDate,
    required this.acceptDate,
    required this.lastUpdateDate,
    required this.acceptedById,
    required this.requestedById,
    required this.url,
    required this.description,
    required this.personCount,
    required this.isOnline});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      status: json['status'],
      name: json['name'],
      addDate: json['add_date'],
      acceptDate: json['accept_date'],
      lastUpdateDate: json['last_update_date'],
      acceptedById: json['accepted_by_id'],
      requestedById: json['requested_by_id'],
      url: json['url'],
      description: json['description'],
      personCount: json['person_count'],
      isOnline: json['is_online'],
    );
  }
}


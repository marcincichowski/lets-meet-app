
import 'package:untitled/models/user_model.dart';

class Meeting {
  int id;
  int ownerId;
  int gameId;
  List<dynamic> participantsId;
  String name;
  dynamic addDate;
  dynamic meetingDate;

  Meeting({
    required this.id,
    required this.ownerId,
    required this.gameId,
    required this.participantsId,
    required this.name,
    required this.addDate,
    required this.meetingDate,});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'],
      ownerId: json['owner_id'],
      gameId: json['game_id'],
      participantsId: json['participants_id'],
      name: json['name'],
      addDate: json['date_joined'],
      meetingDate: json['meeting_date'],
    );
  }
}

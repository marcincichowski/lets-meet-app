
class Participant {
  int id;
  int userId;
  int meetingId;
  String preferedDate;

  Participant({
    required this.id,
    required this.userId,
    required this.meetingId,
    required this.preferedDate,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      userId: json['user_id'],
      meetingId: json['meeting_id'],
      preferedDate: json['prefered_date'],
    );
  }
}

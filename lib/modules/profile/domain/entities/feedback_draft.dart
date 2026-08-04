import 'package:equatable/equatable.dart';

class FeedbackDraft extends Equatable {
  const FeedbackDraft({
    required this.to,
    required this.ccBcc,
    required this.from,
    required this.subject,
    required this.body,
  });

  final String to;
  final String ccBcc;
  final String from;
  final String subject;
  final String body;

  FeedbackDraft copyWith({
    String? to,
    String? ccBcc,
    String? from,
    String? subject,
    String? body,
  }) {
    return FeedbackDraft(
      to: to ?? this.to,
      ccBcc: ccBcc ?? this.ccBcc,
      from: from ?? this.from,
      subject: subject ?? this.subject,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [to, ccBcc, from, subject, body];
}

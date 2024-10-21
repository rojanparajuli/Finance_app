abstract class TokenEvent {}

class SaveToken extends TokenEvent {
  final String token;

  SaveToken({required this.token});

  @override
  List<Object> get props => [token];
}

class RemoveToken extends TokenEvent {
  RemoveToken();

  @override
  List<Object> get props => [];
}

class GetToken extends TokenEvent {
  GetToken();

  @override
  List<Object> get props => [];
}

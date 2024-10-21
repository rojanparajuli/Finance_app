abstract class TokenState {}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokenSaved extends TokenState {}

class TokenRemoved extends TokenState {}

class TokenRetrieved extends TokenState {
  final String token;

  TokenRetrieved({required this.token});

  @override
  List<Object> get props => [token];
}

class TokenError extends TokenState {
  final String error;

  TokenError({required this.error});

  @override
  List<Object> get props => [error];
}

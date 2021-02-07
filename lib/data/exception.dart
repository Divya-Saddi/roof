

class NetworkErrorException implements Exception{
  final String message;

  NetworkErrorException({this.message = 'No Internet Connection Please Try Again Later'});
}

class UnKnownException implements Exception{
  final String message;

  UnKnownException({this.message = 'Unknown error occurred. '});
}


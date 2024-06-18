import 'dart:convert';
import 'package:http/http.dart' as http;

/// The function `documentValidator` validates a Dominican Republic
/// identification document number.
///  @param {string} document - The document number to validate (Cédula de Identidad y Electoral).
/// string representing the document number as input and performs a series of calculations to validate
/// it.
/// @returns The function `documentValidator` is returning a boolean value - `true` if the
/// provided Dominican document number is valid, and `false` if it is not valid.

bool documentValidator(String document) {
  try {
    final String documentId = _removeHyphens(document);

    if (documentId.length != 11) {
      throw Exception('The provided document must have 11 characters.');
    }

    final List<int> digits = documentId.split('').map(int.parse).toList();
    final int checkDigit = _calculateDigits(digits.sublist(0, 10));

    return checkDigit == digits[10];
  } catch (error) {
    print(error);
    return false;
  }
}

/// The function `electoralRollValidation` validates a Dominican Republic national identification
/// document number by removing hyphens, checking its length, and making an API call to verify its
/// validity.
///
/// Args:
///   document (String): The `electoralRollValidation` function you provided is designed to validate a
/// document ID against an external API endpoint. The function first removes any hyphens from the input
/// document ID, checks if the length is 11 characters, and then makes a GET request to the API endpoint
/// for validation.
///
/// Returns:
///   A Future<Map<String, dynamic>> is being returned. The map contains the following keys:
/// - 'statusCode': The HTTP status code of the response.
/// - 'valid': A boolean value indicating whether the document is valid or not.
/// - 'message': A message providing information about the validation result. If no message is provided
/// in the response data, a default message stating that the provided document is valid is
Future<Map<String, dynamic>> electoralRollValidation(String document) async {
  try {
    final String documentId = _removeHyphens(document);

    if (documentId.length != 11) {
      throw Exception('The provided document must have 11 characters.');
    }

    final response = await http.get(Uri.parse(
        'https://api.digital.gob.do/v3/cedulas/$documentId/validate'));
    final responseData = jsonDecode(response.body);

    return {
      'statusCode': response.statusCode,
      'valid': responseData['valid'],
      'message': responseData['message'] ?? 'The provided document is valid.'
    };
  } catch (error) {
    print(error);
    return {'statusCode': 500, 'valid': false, 'message': error};
  }
}

/// The function `_removeHyphens` removes hyphens from a given `documentId` string.
///
/// Returns:
/// returns the  modified string without hyphens.

String _removeHyphens(String documentId) {
  return documentId.replaceAll('-', '');
}

/// The function calculates the check digit for a list of digits using a specific weighting algorithm.
///
/// Args:
///   digits (List<int>): It seems like you have provided the code snippet but missed providing the
/// actual list of digits that should be passed to the `_calculateDigits` function. Could you please
/// provide the list of digits so that I can assist you further with the calculation?

int _calculateDigits(List<int> digits) {
  const List<int> weights = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
  int sum = 0;

  for (int i = 0; i < weights.length; i++) {
    final int product = digits[i] * weights[i];
    sum += _sumDigits(product);
  }

  final int nextTen = ((sum / 10).ceil()) * 10;
  return nextTen - sum;
}

/// The `_sumDigits` function takes an integer as input, converts it to a string, splits it into
/// individual digits, converts each digit back to an integer, and then returns the sum of all the
/// digits.
///
/// Args:
///   num (int): The function `_sumDigits` takes an integer `num` as input and calculates the sum of its
/// digits.
///
/// Returns:
///   The function `_sumDigits` takes an integer `num`, converts it to a string, splits the string into
/// individual characters, converts each character back to an integer, and then calculates the sum of
/// these digits. The function returns the sum of the digits of the input number `num`.

int _sumDigits(int num) {
  return num.toString()
      .split('')
      .map(int.parse)
      .reduce((acc, digit) => acc + digit);
}

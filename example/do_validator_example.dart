import 'package:do_validator/do_validator.dart';

void main() async {
  const document = '12345678902';

  final bool validation = documentValidator(document);
  print(validation);

  final result = await electoralRollValidation(document);
  print(result);
}

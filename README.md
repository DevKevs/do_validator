# Dominican document validation

This package offers a simple and efficient way to validate Dominican Republic ID numbers. Perfect for developers who need to ensure the validity of identity documents in their applications. It checks the format and integrity of the ID number according to official rules.

# Installation

You can install the package using:

### With Dart:
```sh
dart pub add do_validator 
```
### With Flutter:
```sh
flutter pub get do_validator 
```

# Example's

### offline validation
```dart
import 'package:do_validator/do_validator.dart';

void main() {
  const document = '12345678902';

  final bool validation = documentValidator(document);
  print(validation);
}
```
### API call validation
```dart
import 'package:do_validator/do_validator.dart';

void main() async {
  const document = '12345678902';

  final result = await electoralRollValidation(document);
  print(result);
}
```
# API 
```dart
documentValidator(document) //Faster
```

Validates a Dominican identity card number.

### Parameters
document (string): The identity card number to validate 11 characters without special characters.

### Return
boolean: true if the ID number is valid, false otherwise.
<hr>

```dart
//validation by API Call
await electoralRollValidation(document) 
```
Validates a Dominican identity card number by an API Call in the Electoral roll.

### Parameters
document (string): The identity card number to validate 11 characters without special characters.

### Return
```ts
{
    statusCode: number,
    valid: boolean,
    message: string
}
```

# Author
DevKevs
<a href="https://www.linkedin.com/in/kevin-f%C3%A9liz-encarnaci%C3%B3n-a20888200/" target="_blank">LinkedIn</a> <a href="https://devkevs.netlify.app/#/home" target="_blank">Portfolio</a> <a href="https://x.com/DevKevs_" target="_blank">Twitter (X)</a>
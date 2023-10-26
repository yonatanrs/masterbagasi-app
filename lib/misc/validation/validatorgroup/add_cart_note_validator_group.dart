import '../validator/validator.dart';
import 'validator_group.dart';

class AddCartNoteValidatorGroup extends ValidatorGroup {
  Validator noteValidator;

  AddCartNoteValidatorGroup({
    required this.noteValidator
  }) {
    validatorList.add(noteValidator);
  }
}
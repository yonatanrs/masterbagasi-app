import '../validator/validator.dart';
import 'validator_group.dart';

class ModificationNoteValidatorGroup extends ValidatorGroup {
  Validator noteValidator;

  ModificationNoteValidatorGroup({
    required this.noteValidator,
  }) {
    validatorList.add(noteValidator);
  }
}
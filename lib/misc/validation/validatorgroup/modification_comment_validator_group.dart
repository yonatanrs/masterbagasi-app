import '../validator/validator.dart';
import 'validator_group.dart';

class ModificationCommentValidatorGroup extends ValidatorGroup {
  Validator commentValidator;

  ModificationCommentValidatorGroup({
    required this.commentValidator,
  }) {
    validatorList.add(commentValidator);
  }
}
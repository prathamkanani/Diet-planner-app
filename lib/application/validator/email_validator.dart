String? emailValidator(String? value) {
  if(value == null || value.isEmpty) {
    return 'Please enter an email.';
  }
  if(!value.contains('@') || value.contains(' ')) {
    return 'Please enter a valid email.';
  }
  return null;
}
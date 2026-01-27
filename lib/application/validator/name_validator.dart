String? nameValidator(String? value) {
  if(value == null || value.isEmpty) {
    return 'Please enter your name.';
  }
  if(value.contains(RegExp(r'\d'))) {
    return 'Please enter a valid name.';
  }
  return null;
}
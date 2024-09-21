String? fieldRequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'Esse campo é obrigatório';
  }
  return null;
}

String? emailValidator(String? value) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (value == null || value.isEmpty) {
    return 'Por favor, insira seu e-mail.';
  } else if (!emailRegex.hasMatch(value)) {
    return 'Por favor, insira um e-mail válido.';
  }
  return null;
}

String? validateCPF(String? value) {
  if (value == null || value.isEmpty) {
    return 'CPF é obrigatório';
  }

  String cpf = value.replaceAll(RegExp(r'\D'), '');

  if (cpf.length != 11) {
    return 'CPF inválido';
  }

  if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
    return 'CPF inválido';
  }

  int sum = 0;
  for (int i = 0; i < 9; i++) {
    sum += int.parse(cpf[i]) * (10 - i);
  }
  int firstCheck = 11 - (sum % 11);
  if (firstCheck >= 10) firstCheck = 0;

  sum = 0;
  for (int i = 0; i < 10; i++) {
    sum += int.parse(cpf[i]) * (11 - i);
  }
  int secondCheck = 11 - (sum % 11);
  if (secondCheck >= 10) secondCheck = 0;

  if (firstCheck != int.parse(cpf[9]) || secondCheck != int.parse(cpf[10])) {
    return 'CPF inválido';
  }

  return null;
}

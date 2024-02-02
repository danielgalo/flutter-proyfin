/// Devolver fecha de hoy en formato yyyy/mm/dd
String fechaHoy() {
  // hoy
  var dateTime = DateTime.now();

  // Año en formato yyyy
  String year = dateTime.year.toString();

  // Mes en formato mm
  String mes = dateTime.month.toString();
  // Si el mes es menor a 9 (único dígito) añadirle un 0 delante
  if (mes.length == 1) {
    mes = '0$mes';
  }

  // Mes en formato mm
  String dia = dateTime.day.toString();
  // Si el dia es menor a 9 (único dígito) añadirle un 0 delante
  if (dia.length == 1) {
    dia = '0$dia';
  }

  return year + mes + dia;
}

/// Convertir cadena de fecha (yyyymmdd) en objeto DateTime
DateTime dateTimeFromString(String str) {
  int yyyy = int.parse(str.substring(0, 4));
  int mm = int.parse(str.substring(4, 6));
  int dd = int.parse(str.substring(6, 8));

  DateTime dateTime = DateTime(yyyy, mm, dd);
  return dateTime;
}

/// Convertir DateTime a cadena
String stringFromDateTime(DateTime dt) {
  
  String year = dt.year.toString();
  String mes = dt.month.toString();
  // Si el mes es menor a 9 (único dígito) añadirle un 0 delante
  if (mes.length == 1) {
    mes = '0$mes';
  }

  // Mes en formato mm
  String dia = dt.day.toString();
  // Si el dia es menor a 9 (único dígito) añadirle un 0 delante
  if (dia.length == 1) {
    dia = '0$dia';
  }
  return year + mes + dia;
}

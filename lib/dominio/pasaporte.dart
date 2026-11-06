
import 'lugar.dart';

class Pasaporte {
  static const double radioSello = 40;

  final Set<String> _visitados = {};

  // Registrar sello al acercarse a un lugar.
  bool registrarSiCerca(
    Lugar lugar,
    double distanciaMetros,
  ) {
    if (distanciaMetros > radioSello) {
      return false;
    }

    return _visitados.add(lugar.id);
  }

  // Comprobar si el lugar fue visitado.
  bool visitado(String id) =>
      _visitados.contains(id);

  // Cantidad de lugares visitados.
  int get total => _visitados.length;

  // Progreso del recorrido.
  double progreso(int totalLugares) =>
      totalLugares == 0
          ? 0
          : total / totalLugares;
}

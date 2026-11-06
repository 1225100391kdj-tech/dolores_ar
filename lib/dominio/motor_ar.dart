
import 'geo.dart';
import 'lugar.dart';

class LugarVisible {
  final Lugar lugar;
  final double distancia;
  final double x;
  final double profundidad;
  final double escala;

  const LugarVisible(
    this.lugar,
    this.distancia,
    this.x,
    this.profundidad,
    this.escala,
  );
}

// Calcular qué lugares son visibles.
List<LugarVisible> calcularVisibles({
  required Coordenada usuario,
  required double rumbo,
  required List<Lugar> lugares,
  double campoVision = 60,
  double radioMax = 2000,
}) {
  final resultado = <LugarVisible>[];

  for (final l in lugares) {
    final d = distanciaMetros(
      usuario,
      l.coordenada,
    );

    if (d > radioMax) continue;

    final dif = diferenciaAngular(
      rumboGrados(usuario, l.coordenada),
      rumbo,
    );

    final x = posicionHorizontal(
      dif,
      campoVision: campoVision,
    );

    if (x == null) continue;

    final profundidad =
        (d / radioMax).clamp(0.0, 1.0).toDouble();

    resultado.add(
      LugarVisible(
        l,
        d,
        x,
        profundidad,
        1.2 - 0.6 * profundidad,
      ),
    );
  }

  resultado.sort(
    (a, b) => b.distancia.compareTo(a.distancia),
  );

  return resultado;
}

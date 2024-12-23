import 'dart:math';

List<dynamic> selectFlags(List<dynamic> lista) {
  final novaLista = lista.toList();
  final nrg = Random();

  final selected = List.generate(4, (_) {
    final item = novaLista.removeAt(nrg.nextInt(novaLista.length));
    return item;
  });

  lista.remove(selected[0]);
  return selected;
}

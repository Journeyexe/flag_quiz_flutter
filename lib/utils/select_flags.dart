import 'dart:math';

List<dynamic> selectFlags(List<dynamic> lista) {
  final novaLista = lista.toList(); // Copia a lista original
  final nrg = Random();

  final selected = List.generate(4, (_) {
    final item = novaLista.removeAt(nrg.nextInt(novaLista.length)); // Use novaLista.length
    return item;
  });

  lista.remove(selected[0]); // Remova a resposta correta da lista original
  return selected;
}

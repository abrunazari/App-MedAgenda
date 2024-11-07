String formatPrice(int price) {
  return 'R\$ ${(price / 100).toStringAsFixed(2).replaceAll('.', ',')}';
}

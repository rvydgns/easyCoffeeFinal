import 'package:flutter/cupertino.dart';
import 'drink.dart';


class Shop extends ChangeNotifier{
  final List <Drink> _drinkMenu = [
    Drink(
      name: "Latte",
      price: "130.00",
      imagePath: "lib/images/coffee-latte.png",
      rating: "4.5",
      description: "Sütle yumuşatılmış, espresso bazlı klasik kahve.",
    ),
    Drink(
      name: "Espresso",
      price: "80.00",
      imagePath: "lib/images/expresso.png",
      rating: "4.7",
      description: "Klasik Espresso.",
    ),
    Drink(
      name: "Filtre Kahve",
      price: "100.00",
      imagePath: "lib/images/hot-coffee.png",
      rating: "4.6",
      description: "Taze Arabica çekirdekleriyle kağıt filtreyle demlenir.",
    ),
    Drink(
      name: "Şekerli Filtre Kahve",
      price: "100.00",
      imagePath: "lib/images/hot-coffee-w-sugar.png",
      rating: "4.6",
      description: "Demlenmiş sade kahveye şeker eklenmiş versiyonu. Tatlı içim tercih edenler için uygundur.",
    ),
    Drink(
      name: "Çay",
      price: "130.00",
      imagePath: "lib/images/hot-tea.png",
      rating: "4.8",
      description: "Siyah çay yapraklarından demlenerek hazırlanır. Sıcak servis edilir.",
    ),
    Drink(
      name: "Ice Americano",
      price: "150.00",
      imagePath: "lib/images/ice americano.png",
      rating: "4.4",
      description: "Espresso shot’larının soğuk suyla seyreltilmiş hali. Buzla servis edilir, sade ve hafif içimlidir.",
    ),
    Drink(
      name: "Ice Latte",
      price: "160.00",
      imagePath: "lib/images/ice latte.png",
      rating: "5.0",
      description: "Espresso üzerine soğuk süt eklenerek hazırlanır. Yumuşak içimli ve sütlü soğuk kahve seçeneğidir.",
    ),
  ];


  List <Drink> _cart = [];
  List <Drink> get drinkMenu => _drinkMenu;
  List <Drink> get cart => _cart;


  //add to cart
  void addToCart(Drink drinkItem, int quantity) {
    for (int i=0; i < quantity; i++) {
      _cart.add(drinkItem);
    }
    notifyListeners();
  }
  //remove from cart
  void removeFromCart(Drink drink) {
    _cart.remove(drink);
    notifyListeners();
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Boutique';

  @override
  String get home => 'Accueil';

  @override
  String get favorites => 'Favoris';

  @override
  String get cart => 'Panier';

  @override
  String get profile => 'Profil';

  @override
  String get orders => 'Commandes';

  @override
  String get productDetail => 'Détail du produit';

  @override
  String get addToCart => 'Ajouter au panier';

  @override
  String addedToCart(String name) {
    return '$name ajouté au panier';
  }

  @override
  String get viewCart => 'Voir';

  @override
  String get emptyCart => 'Votre panier est vide';

  @override
  String get emptyFavorites => 'Aucun favori pour le moment';

  @override
  String get emptyOrders => 'Aucune commande pour le moment';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Commander';

  @override
  String get checkoutSoon => 'Le paiement arrive bientôt';

  @override
  String get quantity => 'Quantité';

  @override
  String get noProductFound => 'Aucun produit trouvé';

  @override
  String get productNotFound => 'Produit introuvable';

  @override
  String get error => 'Erreur';

  @override
  String get name => 'Nom';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Téléphone';

  @override
  String get address => 'Adresse';

  @override
  String get sortBy => 'Trier par';

  @override
  String get filterBy => 'Filtrer';

  @override
  String get allCategories => 'Toutes';

  @override
  String get relevance => 'Pertinence';

  @override
  String get priceLowHigh => 'Prix croissant';

  @override
  String get priceHighLow => 'Prix décroissant';

  @override
  String get topRated => 'Mieux notés';

  @override
  String get rating => 'Note';

  @override
  String get description => 'Description';

  @override
  String get orderPlaced => 'Commande passée !';

  @override
  String get orderDate => 'Date';

  @override
  String get orderStatus => 'Statut';

  @override
  String get orderStatusPending => 'En attente';

  @override
  String get orderStatusShipped => 'Expédiée';

  @override
  String get orderStatusDelivered => 'Livrée';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get darkMode => 'Thème sombre';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get delete => 'Supprimer';

  @override
  String get clearCart => 'Vider le panier';

  @override
  String get clearCartConfirm => 'Vider tout le panier ?';

  @override
  String items(int count) {
    return '$count article(s)';
  }
}

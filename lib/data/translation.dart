class Translations {
  static const Map<String, String> english = {
    'discover_movies': 'Discover movies effortlessly with Kinema.',
    'get_info': 'Get detailed information and reviews.',
    'rate_share': 'Rate and share your favorite movies!',
    'create_account': 'Create Account',
  };

  static const Map<String, String> zulu = {
    'discover_movies': 'Thola amafilimu kalula nge-Kinema.',
    'get_info': 'Thola imininingwane eningiliziwe kanye nezibuyekezo.',
    'rate_share': 'Beka isilinganiso futhi wabelane ngama-movie owathandayo!',
    'create_account': 'Dala I-akhawunti',
  };

  static const Map<String, String> xhosa = {
    'discover_movies': 'Fumana iifilimu kalula nge-Kinema.',
    'get_info': 'Fumana iinkcukacha kunye nohlaziyo.',
    'rate_share': 'Beka amaxabiso kwaye wabelane ngeefilimu ozithandayo!',
    'create_account': 'Yenza i-akhawunti',
  };

  static const Map<String, String> afrikaans = {
    'discover_movies': 'Ontdek films sonder moeite met Kinema.',
    'get_info': 'Kry gedetailleerde inligting en resensies.',
    'rate_share': 'Beloon en deel jou gunsteling films!',
    'create_account': 'Skep Rekening',
  };

  static Map<String, String> getTranslations(String languageCode) {
    switch (languageCode) {
      case 'zu':
        return zulu;
      case 'xh':
        return xhosa;
      case 'af':
        return afrikaans;
      case 'en':
      default:
        return english;
    }
  }
}

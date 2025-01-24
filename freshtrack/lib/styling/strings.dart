class Strings {
  Strings._();

  static const List<String> onBoardTitle = [
    "Never Waste Food Again",
    "Smart Recipes, Zero Waste"
  ];

  static const List<String> onBoardDescription = [
    "Track expiry dates effortlessly and stay notified to make the most of your groceries.",
    "Get personalized AI recipes for items nearing expiry and reduce food waste with ease."
  ];

  static String prompt(List items) {
    String formattedItems = items.join(", ");
    return """Suggest 3 vegetarian recipes using the ingredients:$formattedItems. Provide the response as a list of maps, where each map contains two keys: title (the name of the dish in exactly three words) and making (a brief description of how to prepare the recipe in 15-20 Lines) and ingredients with a string containing 4 ingredients. Ensure the recipes are real, beginner-friendly, and commonly available online.""";
    //return """Suggest 4 vegetarian recipes using the ingredients:${formattedItems}. Provide the response as a list of maps, where each map contains two keys: title (the name of the dish in exactly three words) and making (a brief description of how to prepare the recipe in 15-20 Lines). Ensure the recipes are real, beginner-friendly, and commonly available online.Response should just include the list""";
  }
}

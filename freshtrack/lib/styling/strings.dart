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

  static String prompt(List items){
    String formattedItems = items.join(", ");
    return """Suggest 3 vegetarian recipes based on the ingredients: $formattedItems. The response should only include the titles and making of the recipes, with each recipe being a real dish available on the internet. Ensure the recipes are simple and beginner-friendly, with a medium length description of the recipe and its making process. Structure the response as a list of maps, where each map contains two keys: title and making. The title should specify the name of the dish, and making should provide a concise, medium-length description of how to prepare the recipe.""";
  }
}

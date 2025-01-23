// class Responseformatter {
//   static List<Map<String, String>> formatResponse(String response) {
//     List<Map<String, String>> recipes = [];
//     print("response is ${response}");

//     List<String> lines = response.split("\\n");
//     print("Line sis $lines");
//     for (int i = 0; i < lines.length; i++) {
//       final body = {
//         "title": lines[i].split("%")[0],
//         "making": lines[i].split("%")[1]
//       };
//       recipes.add(body);
//     }

//     return recipes;
//   }
// }

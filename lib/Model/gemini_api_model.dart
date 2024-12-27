// class GeminiModel {
//   List<Contents>? contents;
//   GenerationConfig? generationConfig;
//
//   GeminiModel({this.contents, this.generationConfig});
//
//   GeminiModel.fromJson(Map<String, dynamic> json) {
//     if (json['contents'] != null) {
//       contents = <Contents>[];
//       json['contents'].forEach((v) {
//         contents!.add(new Contents.fromJson(v));
//       });
//     }
//     generationConfig = json['generationConfig'] != null
//         ? new GenerationConfig.fromJson(json['generationConfig'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.contents != null) {
//       data['contents'] = this.contents!.map((v) => v.toJson()).toList();
//     }
//     if (this.generationConfig != null) {
//       data['generationConfig'] = this.generationConfig!.toJson();
//     }
//     return data;
//   }
// }
//
// class Contents {
//   List<Parts>? parts;
//
//   Contents({this.parts});
//
//   Contents.fromJson(Map<String, dynamic> json) {
//     if (json['parts'] != null) {
//       parts = <Parts>[];
//       json['parts'].forEach((v) {
//         parts!.add(new Parts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.parts != null) {
//       data['parts'] = this.parts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Parts {
//   String? text;
//   InlineData? inlineData;
//
//   Parts({this.text, this.inlineData});
//
//   Parts.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     inlineData = json['inline_data'] != null
//         ? new InlineData.fromJson(json['inline_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['text'] = this.text;
//     if (this.inlineData != null) {
//       data['inline_data'] = this.inlineData!.toJson();
//     }
//     return data;
//   }
// }
//
// class InlineData {
//   String? mimeType;
//   String? data;
//
//   InlineData({this.mimeType, this.data});
//
//   InlineData.fromJson(Map<String, dynamic> json) {
//     mimeType = json['mime_type'];
//     data = json['data'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['mime_type'] = this.mimeType;
//     data['data'] = this.data;
//     return data;
//   }
// }
//
// class GenerationConfig {
//   double? temperature;
//   int? topK;
//   int? topP;
//   int? maxOutputTokens;
//
//   GenerationConfig(
//       {this.temperature, this.topK, this.topP, this.maxOutputTokens});
//
//   GenerationConfig.fromJson(Map<String, dynamic> json) {
//     temperature = json['temperature'];
//     topK = json['topK'];
//     topP = json['topP'];
//     maxOutputTokens = json['maxOutputTokens'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['temperature'] = this.temperature;
//     data['topK'] = this.topK;
//     data['topP'] = this.topP;
//     data['maxOutputTokens'] = this.maxOutputTokens;
//     return data;
//   }
// }


// Main class for the GeminiModel
class GeminiModel {
  final List<Contents>? contents;
  final GenerationConfig? generationConfig;

  GeminiModel({this.contents, this.generationConfig});

  Map<String, dynamic> toJson() => {
    if (contents != null)
      "contents": contents!.map((content) => content.toJson()).toList(),
    if (generationConfig != null) "generationConfig": generationConfig!.toJson(),
  };
}

class Contents {
  final List<Parts>? parts;

  Contents({this.parts});

  Map<String, dynamic> toJson() => {
    if (parts != null) "parts": parts!.map((part) => part.toJson()).toList(),
  };
}

class Parts {
  final String? text;
  final InlineData? inlineData;

  Parts({this.text, this.inlineData});

  Map<String, dynamic> toJson() => {
    if (text != null) "text": text,
    if (inlineData != null) "inline_data": inlineData!.toJson(),
  };
}

class InlineData {
  final String? mimeType;
  final String? data;

  InlineData({this.mimeType, this.data});

  Map<String, dynamic> toJson() => {
    if (mimeType != null) "mime_type": mimeType,
    if (data != null) "data": data,
  };
}

class GenerationConfig {
  final double? temperature;
  final int? topK;
  final double? topP;
  final int? maxOutputTokens;

  GenerationConfig({this.temperature, this.topK, this.topP, this.maxOutputTokens});

  Map<String, dynamic> toJson() => {
    if (temperature != null) "temperature": temperature,
    if (topK != null) "topK": topK,
    if (topP != null) "topP": topP,
    if (maxOutputTokens != null) "maxOutputTokens": maxOutputTokens,
  };
}

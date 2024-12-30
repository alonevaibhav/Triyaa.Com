
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

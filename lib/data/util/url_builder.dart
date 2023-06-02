String buildUrlWithParams(String baseUrl, Map<String, dynamic> params) {
  for (int i = 0; i < params.entries.length; i++) {
    final currentEntry = params.entries.elementAt(i);
    baseUrl += "${i == 0 ? "?" : "&"}${currentEntry.key}=${currentEntry.value}";
  }
  return baseUrl;
}

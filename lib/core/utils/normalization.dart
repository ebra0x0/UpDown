class Normalization {
  static final RegExp kImageRegex = RegExp(
      r'^[^\s]+\/[\w\-.]+\.(jpg|jpeg|png|gif|bmp|webp|tiff|ico)$',
      caseSensitive: false);
  static final RegExp kVideoRegex = RegExp(
      r'^[^\s]+\/[\w\-.]+\.(mp4|mkv|mov|avi|wmv|flv|webm|mpeg|mpg|m4v)$',
      caseSensitive: false);

  static final kPhoneRegex = RegExp(r'^01[0125][0-9]{8}$');

  static final kNameRegex =
      RegExp(r'^[\u0621-\u064Aa-zA-Z]{3,}(?: [\u0621-\u064Aa-zA-Z]{3,})*$');

  static final kEmailRegex = RegExp(
      r'^(?=[^@]*[a-zA-Z])([a-zA-Z0-9._%+-]+)@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  static final RegExp kPasswordRegex =
      RegExp(r'^(?=.*?)(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
}

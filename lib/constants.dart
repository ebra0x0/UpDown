const Duration kTranstionDuration = Duration(milliseconds: 100);
const Map<String, String> kIssuesList = {
  "Door_Not_Opening": "الباب لا يفتح",
  "Stuck_Between_Floors": "عالق بين الأدوار",
  "Noise": "ضوضاء",
  "Not_Responding": "لا يستجيب للطلبات",
  "Button_Not_Responding": "زر لا يستجيب",
  "Above_Floor": "مرتفع عن الطابق",
  "Other": "أخرى",
};
const String kAvatarsBucket = "avatars";
const String kIssuesBucket = "issues";
const String kAvatarsBucketFolder = "Clients";
const Map<String, String> kIssuesBucketFolders = {
  "image": "images",
  "video": "videos",
  "other": "other"
};

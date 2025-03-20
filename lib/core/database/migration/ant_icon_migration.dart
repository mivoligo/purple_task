import 'package:ant_icons/ant_icons.dart';

final antIconsV1ToV2 = {
  0xe8a6: AntIcons.folderFilled.codePoint,
  0xe9ec: AntIcons.homeFilled.codePoint,
  0xea28: AntIcons.shoppingFilled.codePoint,
  0xe9e1: AntIcons.carFilled.codePoint,
  0xe863: AntIcons.giftFilled.codePoint,
  0xe9fc: AntIcons.mailFilled.codePoint,
  0xea09: AntIcons.phoneFilled.codePoint,
  0xea01: AntIcons.messageFilled.codePoint,
  0xea11: AntIcons.printerFilled.codePoint,
  0xe871: AntIcons.codeFilled.codePoint,
  0xe880: AntIcons.databaseFilled.codePoint,
  0xe870: AntIcons.cloudFilled.codePoint,
  0xe9e2: AntIcons.githubFilled.codePoint,
  0xe9e3: AntIcons.gitlabFilled.codePoint,
  0xe891: AntIcons.experimentFilled.codePoint,
  0xea31: AntIcons.starFilled.codePoint,
  0xe9ea: AntIcons.heartFilled.codePoint,
  0xea2e: AntIcons.smileFilled.codePoint,
  0xe85f: AntIcons.bulbFilled.codePoint,
  0xe862: AntIcons.cameraFilled.codePoint,
  0xe87e: AntIcons.customerServiceFilled.codePoint,
  0xea19: AntIcons.readFilled.codePoint,
  0xea0a: AntIcons.pictureFilled.codePoint,
  0xeb64: AntIcons.safetyCertificateFilled.codePoint,
  0xea37: AntIcons.tagFilled.codePoint,
  0xea3e: AntIcons.trophyFilled.codePoint,
  0xea3c: AntIcons.toolFilled.codePoint,
  0xea15: AntIcons.pushpinFilled.codePoint,
  0xea12: AntIcons.profileFilled.codePoint,
  0xea13: AntIcons.projectFilled.codePoint,
  0xe8a4: AntIcons.fireFilled.codePoint,
};

int antIconFromV1ToV2(int v1) {
  return antIconsV1ToV2[v1] ?? AntIcons.folderFilled.codePoint;
}

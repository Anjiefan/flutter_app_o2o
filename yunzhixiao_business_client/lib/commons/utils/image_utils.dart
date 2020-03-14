import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yunzhixiao_business_client/commons/constants/dicts.dart';

class ImageUtils {
  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl,
      {String holderImg: 'none'}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl,
        errorListener: () => log("图片加载失败"));
  }

  static Future<String> putFile(File uploadFile, Function onSuccess) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(uploadFile.openRead()));
    var length = await uploadFile.length();
    var uri = Uri.parse(
        "https://avefaaux.api.lncld.net/1.1/files/${basename(uploadFile.path)}");
    String contentType;
    try {
      contentType = Dicts.MIMES[extension(uploadFile.path)];
    } on Exception catch (e) {
      return null;
    }
    var headers = {
      "X-LC-Id": "aveFaAUxq89hJCelmHX33pLU-gzGzoHsz",
      "X-LC-Key": "SX8gmajxVuYL4MvfOCTvV5zR",
      "Content-Type": contentType
    };
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(uploadFile.path));
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201) {
      response.stream.transform(utf8.decoder).listen(onSuccess);
    } else {
      return "FILE_UPLOAD_ERROR";
    }
  }
}

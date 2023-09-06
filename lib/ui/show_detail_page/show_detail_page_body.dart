import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/model/page_item.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends StatelessWidget {
  // 日記のページデータ
  final PageItem _page;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required PageItem page,
  }): _page = page;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Container(
          //   height: 200,
          //   width: double.infinity,
          //   color: Colors.grey,
          //   child: Image.file(File(_page.image.path)),
          // ),
          Image.file(File(_page.image.path)),
          const SizedBox(height: 16,),

          Text(_page.title, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 16,),

          Text(_page.getFormattedDate(), style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 16,),

          Text(_page.content, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 16,),
        ],
      )
    );
  }
}

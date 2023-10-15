import 'package:flutter/cupertino.dart';
import 'package:image_diary/app_container.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/add_page/add_page_view_model_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_page_view_model.g.dart';

@riverpod
class AddPageViewModel extends _$AddPageViewModel {
  @override
  AddPageViewModelState build() {
    return AddPageViewModelState(
      titleController: TextEditingController(),
      contentController: TextEditingController(),
      imagePicker: ImagePicker(),
      image: null,
    );
  }

  /// 端末に存在する画像を選択し、取得する。
  Future<void> pickImage() async {
    final image = await state.imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );

    state = state.copyWith(image: image);
  }

  /// ページを登録する
  Future<void> addPage({
    Function()? onLoading,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    if(!_hasRequiredData()) {
      if(onFailure != null) onFailure();
      return;
    }

    if(onLoading != null) onLoading();

    final page = PageModel(
      title: state.titleController.text,
      content: state.contentController.text,
      date: DateTime.now().millisecondsSinceEpoch,
      imagePath: state.image?.path ?? "",
    );

    final repository = ref.read(pageRepositoryProvider);
    await repository.insert(page);

    if(onSuccess != null) onSuccess();
  }

  /// ページ登録のために必要なデータが揃っているか確認する処理
  ///
  /// @return ture  過不足なく入力されている
  ///         false 入力項目に不備がある
  bool _hasRequiredData() {
    bool result = true;

    if((state.titleController.text == "") ||
        (state.contentController.text == "") ||
        (state.image == null)) {

      result = false;
    }

    return result;
  }

  Widget buildImageContainerContent({
    required Widget Function(String path) hasImage,
    required Widget Function() noImage
  }) {
    if(state.image == null) {
      return noImage();
    }

    return hasImage(state.image!.path);
  }
}

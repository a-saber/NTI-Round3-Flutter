import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/core/widgets/image_manager/cubit/image_manager_state.dart';
import 'package:image_picker/image_picker.dart';

class ImageManagerCubit extends Cubit<ImageManagerState>
{
  ImageManagerCubit() : super(ImageManagerInitial());
  static ImageManagerCubit get(context) => BlocProvider.of(context);

  pickImage()async
  {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      emit(ImageManagerPicked(image));
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../CategoryRepository.dart';
import 'CategoryEvent.dart';
import 'categoryState.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
    final CategoryRepository categoryRepository;

    CategoryBloc(this.categoryRepository) : super(CategoryLoadingState()){
      on<CategoryLoadEvent>(_onCategoryLoadEvent);
      on<OnPageChangedEvent>((event, emit) {
          emit(OnPageChangedState(event.index));
      });
    }

    void _onCategoryLoadEvent(CategoryLoadEvent event,Emitter<CategoryState> emit) async {
      try{
        final categoryList = await categoryRepository.fetchCategoryWiseDrinks();
        if(categoryList.isNotEmpty){
          emit(CategoryLoadedState(categoryList));
        }else{
          emit(CategoryLoadingState());
        }
      }catch(e){
        emit(CategoryErrorState(e.toString()));
      }
    }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../CategoryRepository.dart';
import 'CategoryEvent.dart';
import 'categoryState.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
    final CategoryRepository categoryRepository;

    CategoryBloc(this.categoryRepository) : super(CategoryState()){
      on<CategoryLoadEvent>(_onCategoryLoadEvent);
    }

    void _onCategoryLoadEvent(CategoryLoadEvent event,Emitter<CategoryState> emit)async{
      emit(CategoryLoadedState([],false));
      // try{
      //   final category = await categoryRepository.fetchCategoryWiseDrinks();
      //   if(category.isNotEmpty){
      //     emit(CategoryLoadedState(category,true));
      //   }
      // }catch(e){
      //   emit(CategoryErrorState(e.toString()));
      // }
    }
}
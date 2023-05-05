

import 'package:flutter_bloc/flutter_bloc.dart';

import '../DrinkRepository.dart';
import 'DrinkEvent.dart';
import 'DrinkState.dart';

class DrinkBloc extends Bloc<DrinkEvent,DrinkState>{
  final DrinkRepository drinkRepository;

  DrinkBloc(this.drinkRepository) : super(DrinkLoadingState()){
    on<DrinkLoadEvent>((event, emit) async{
        try{
         final drink = await drinkRepository.fetchSpecificDrink();
         if(drink.drinks![0].idDrink!.isNotEmpty){
            emit(DrinkLoadedState(drink));
         }else{
           emit(DrinkLoadingState());
         }
        }catch(e){
          emit(DrinkErrorState(e.toString()));
        }
    });
  }



}
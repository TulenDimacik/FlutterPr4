import 'package:bloc/bloc.dart';
import 'package:blok/cubit/listview_state.dart';

class ListViewCubit extends Cubit<ListViewState> {
  ListViewCubit() : super(ListViewState(clicks: []));

  void writeClicks(String clicks1) {
    List clicks = state.clicks;
    clicks.add(clicks1);
    emit(ListViewState(clicks: clicks));
  }
}
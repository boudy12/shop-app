import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;



  List<String> titles = [
    'Tasks',
    'Done',
    'Archive',
  ];

  late Database database;





  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database Created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
        ).then((value) {
          print('table created');
        }).catchError((error){
          print('error when created table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  })async
  {
    await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks (title, date, time, status) VALUES("$title","$date","$time","new")'
      ).then((value){
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);

      }).catchError((error){
        print(error.toString());
      });

      return null;
    });
  }

  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['status'] == 'new')
          {
            newTasks.add(element);
          }
        else if(element['status'] == 'Done')
        {
          doneTasks.add(element);
        }
        else
        {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
  required String status,
  required int id,
})
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status',id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  })
  {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
  required bool isShow,
  required IconData icon,

}){
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;
  bool isLight = false;
  IconData lightIcon = Icons.brightness_4_outlined;

  void changeMode({ bool? fromShared })
  {
    if(fromShared != null)
      {
        isDark = fromShared;
        emit(AppChangeModeState());
      }
    else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
import 'package:chocauto/Models/Chocadeira.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chocauto/Models/Auth.dart';
import 'package:chocauto/Models/Dash.dart';

class AppController {
  static Box<Auth> getAuths() => Hive.box<Auth>('auths');

  static Box<Dash> getDashs() => Hive.box<Dash>('dashs');
  static Box<Chocadeira> getChocadeiras() =>
      Hive.box<Chocadeira>('chocadeiras');

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AuthAdapter());
    Hive.registerAdapter(DashAdapter());
    Hive.registerAdapter(ChocadeiraAdapter());
    await Hive.openBox<Auth>('auths');
    await Hive.openBox<Dash>('dashs');
    await Hive.openBox<Chocadeira>('chocadeiras');
  }

  static bool register(Auth auth) {
    try {
      getAuths().add(auth);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool login(Auth auth) {
    try {
      return getAuths()
              .values
              .where((element) => element.isEqual(auth))
              .length >
          0;
    } catch (e) {
      return false;
    }
  }

  static bool addDash(Dash dash) {
    try {
      getDashs().add(dash);
      return true;
    } catch (e) {
      return false;
    }
  }

  static double temperaturaMedia(DateTime inico, DateTime fim) {
    try {
      var dashs = getDashs().values.where((element) {
        return (element.horario == inico || element.horario.isAfter(inico)) &&
            (element.horario.isBefore(fim) || element.horario == fim);
      });
      if (dashs.length > 0) {
        var media = 0.0;
        dashs.forEach((element) {
          media += element.temperetura;
        });
        return (media / dashs.length);
      } else {
        return 0.0;
      }
    } catch (e) {
      return 0.0;
    }
  }

  static double humidadeMedia(DateTime inico, DateTime fim, String nome) {
    try {
      var dashs = getDashs().values.where((element) {
        return (element.horario == inico || element.horario.isAfter(inico)) &&
            (element.horario.isBefore(fim) || element.horario == fim);
      });
      if (dashs.length > 0) {
        var media = 0.0;
        dashs.forEach((element) {
          media += element.humidade;
        });
        return (media / dashs.length);
      } else {
        return 0.0;
      }
    } catch (e) {
      return 0.0;
    }
  }
}

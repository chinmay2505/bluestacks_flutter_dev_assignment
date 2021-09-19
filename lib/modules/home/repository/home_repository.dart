import 'package:bluestacks_flutter_dev_assignment/application.dart';
import 'package:bluestacks_flutter_dev_assignment/modules/home/models/tournaments_model.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/services/rest_api_service.dart';

abstract class HomeRepository {
  /// To fetch the tournaments from the
  /// API: http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all
  Future<dynamic> fetchTournaments({String cursor});
}

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<dynamic> fetchTournaments({String cursor = ""}) async {
    try {
      final response = await Application.restService!.requestCall(
          apiEndPoint:
              "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=${cursor}",
          method: RestAPIRequestMethods.GET);
      return TournamentsModel.fromJson(response);
    } catch (e) {
      return "failed_to_load_content";
    }
  }
}

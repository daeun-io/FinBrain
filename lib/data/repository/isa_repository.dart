import 'package:finbrain/data/data_sources/isa_data_source.dart';
import 'package:finbrain/data/models/request/isa_search_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/data/models/entities/isa_join_status.dart';
import 'package:finbrain/data/models/entities/isa_management_status.dart';

class IsaRepository {
  Future<(int, List<IsaJoinStatus>)> fetchJoinStatus(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
  ) async {
    final client = http.Client();
    final dataStore = IsaRemoteDataSource(client);
    final options = IsaSearchOptions(
      serviceKey: dotenv.env["PUBLIC_API"] ?? "",
      resultType: "json",
      pageNo: pageNo,
      numOfRows: numOfRows,
      baseYearMonth: baseYearMonth,
    );

    try {
      final Map<String, dynamic> result = await dataStore.fetchJoinStatus(
        options,
      );

      final totalCount =
          int.tryParse(result["response"]["body"]["totalCount"].toString()) ??
          0;
      if (totalCount == 0) {
        return (0, <IsaJoinStatus>[]);
      }

      final rawItems =
          result["response"]["body"]["items"]["item"] as Iterable<dynamic>;
      final List<IsaJoinStatus> items = rawItems
          .map<IsaJoinStatus?>((e) {
            if (e == null ||
                e["cmpyCnt"] == null ||
                e["jnpnCnt"] == null ||
                e["invAmt"] == null ||
                e["basDt"] == null ||
                e["isaForm"] == null ||
                e["ctg"] == null) {
              return null;
            }
            return IsaJoinStatus(
              companyCount: int.tryParse(e["cmpyCnt"]),
              joinMemberCount: int.tryParse(e["jnpnCnt"]),
              investmentAmount: int.tryParse(e["invAmt"]),
              baseDate: e["basDt"],
              isaForm: e["isaForm"],
              category: e["ctg"],
            );
          })
          .whereType<IsaJoinStatus>()
          .toList();
      return (totalCount, items);
    } catch (error) {
      print("error: Failed to load data $error");
      return (0, <IsaJoinStatus>[]);
    } finally {
      client.close();
    }
  }

  Future<(int, List<IsaManagementStatus>)> fetchManagementStatus(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
  ) async {
    final client = http.Client();
    final dataStore = IsaRemoteDataSource(client);
    final options = IsaSearchOptions(
      serviceKey: dotenv.env["PUBLIC_API"] ?? "",
      resultType: "json",
      pageNo: pageNo,
      numOfRows: numOfRows,
      baseYearMonth: baseYearMonth,
    );
    try {
      final Map<String, dynamic> response = await dataStore
          .fetchManagementStatus(options, ctg);

      final totalCount =
          int.tryParse(response["response"]["body"]["totalCount"].toString()) ??
          0;
      if (totalCount == 0) {
        return (0, <IsaManagementStatus>[]);
      }

      final rawItems =
          response["response"]["body"]["items"]["item"] as Iterable<dynamic>;
      final List<IsaManagementStatus> items = rawItems
          .map<IsaManagementStatus?>((e) {
            if (e == null ||
                e["basDt"] == null ||
                e["bzds"] == null ||
                e["ctg"] == null ||
                e["isaForm"] == null ||
                e["incAstCtg"] == null ||
                e["amt"] == null) {
              return null;
            }
            return IsaManagementStatus(
              baseDate: e["basDt"],
              businessDomain: e["bzds"],
              category: e["ctg"],
              isaForm: e["isaForm"],
              includeAssetCtg: e["incAstCtg"],
              amount: double.tryParse(e["amt"]),
            );
          })
          .whereType<IsaManagementStatus>()
          .toList();
      return (totalCount, items);
    } catch (error) {
      print("error: Failed to load data, $error");
      return (0, <IsaManagementStatus>[]);
    } finally {
      client.close();
    }
  }
}

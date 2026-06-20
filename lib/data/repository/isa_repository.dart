import 'package:finbrain/data/data_sources/isa_data_source.dart';
import 'package:finbrain/data/models/request/isa_search_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:finbrain/data/models/entities/isa_join_status.dart';
import 'package:finbrain/data/models/entities/isa_management_status.dart';

class IsaRepository {
  Future<List<IsaJoinStatus>> fetchJoinStatus(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String domain,
    String isaForm,
  ) async {
    final client = http.Client();
    final dataStore = IsaRemoteDataSource(client);
    final options = IsaSearchOptions(
      serviceKey: dotenv.env["PUBLIC_API"] ?? "",
      resultType: "json",
      pageNo: pageNo,
      numOfRows: numOfRows,
      baseYearMonth: baseYearMonth
    );

    try {
      final Map<String, dynamic> result = await dataStore.fetchJoinStatus(
        options, domain, isaForm
      );
      final items = result["response"]["body"]["items"]["item"].map(
        (e) => IsaJoinStatus(
          companyCount: e["cmpyCnt"],
          joinMemberCount: e["jnpnCnt"],
          investmentAmount: e["invAmt"],
          baseDate: e["basDt"],
          isaForm: e["isaForm"],
          category: e["ctg"],
        ),
      );
      return items;
    } catch (error) {
      print("error: Failed to load data");
      return [];
    } finally {
      client.close();
    }
  }

  Future<List<IsaManagementStatus>> fetchManagementStatus(
    String pageNo,
    String numOfRows,
    String baseYearMonth,
    String ctg,
    String domain,
    String isaForm
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
          .fetchManagementStatus(options, ctg, domain, isaForm);
      final items = response["response"]["body"]["items"]["item"].map(
        (e) => IsaManagementStatus(
          baseDate: e["basDt"],
          businessDomain: e["bzds"],
          category: e["ctg"],
          isaForm: e["isaForm"],
          includeAssetCtg: e["incAstCtg"],
          amount: e["amt"],
        ),
      );
      return items;
    } catch (error) {
      print("error: Failed to load data");
      return [];
    } finally {
      client.close();
    }
  }
}

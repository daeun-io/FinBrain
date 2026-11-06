import 'package:finbrain/data/data_source/notice_data_source.dart';
import 'package:finbrain/data/model/entities/notice.dart';

class NoticeRepository {
  final dataSource = NoticeDataSource();

  Future<List<Notice>> fetchNotices() async {
    final queries = await dataSource.fetchNotices();
    final notices = <Notice>[];

    for(final query in queries){
      notices.add(
        Notice(
          title: query.data()["title"],
          content: query.data()["content"]
        )
      );
    }
    return notices;
  }
}
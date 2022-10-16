import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:sats/model/cypherpost.dart';

part 'network-chat-history.g.dart';
part 'network-chat-history.freezed.dart';

@freezed
class NetworkChatHistory with _$NetworkChatHistory {
  @HiveType(typeId: 12, adapterName: 'NetworkChatHistoryClassAdapter')
  const factory NetworkChatHistory({
    @HiveField(0) required String counterParty,
    @HiveField(1) required List<PlainPost> posts,
  }) = _NetworkChatHistory;
  const NetworkChatHistory._();
}

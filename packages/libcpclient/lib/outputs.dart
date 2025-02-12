// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

class SMError {
  const SMError(
    this.kind,
    this.message,
  );
  factory SMError.fromJson(String data) {
    final json = jsonDecode(data);
    return SMError(
      json['kind'] as String,
      json['message'] as String,
    );
  }
  final String kind;
  final String message;

  String get oneliner => '$kind:$message';
}

class SocialRoot {
  // ignore: avoid_positional_boolean_parameters
  const SocialRoot(this.socialRoot);
  factory SocialRoot.fromJson(String data) {
    final json = jsonDecode(data);
    return SocialRoot(
      json['social_root'] as String,
    );
  }
  final String socialRoot;
}

class ServerIdentity {
  const ServerIdentity(
    this.name,
    this.kind,
  );
  factory ServerIdentity.fromJson(String data) {
    final json = jsonDecode(data);
    return ServerIdentity(
      json['name'] as String,
      json['kind'] as String,
    );
  }
  final String name;
  final String kind;
}

class Invitation {
  const Invitation(this.inviteCode);
  factory Invitation.fromJson(String data) {
    final json = jsonDecode(data);
    return Invitation(
      json['invite_code'] as String,
    );
  }
  final String inviteCode;
}

class MemberIdentity {
  const MemberIdentity(
    this.username,
    this.pubkey,
  );
  factory MemberIdentity.fromJson(String data) {
    final json = jsonDecode(data);
    return MemberIdentity(
      json['username'] as String,
      json['pubkey'] as String,
    );
  }
  final String username;
  final String pubkey;
}

class ServerStatus {
  const ServerStatus(this.status);
  factory ServerStatus.fromJson(String data) {
    final json = jsonDecode(data);
    return ServerStatus(
      json['status'] as bool,
    );
  }
  final bool status;
}

class PostId {
  const PostId(this.id);
  factory PostId.fromJson(String data) {
    final json = jsonDecode(data);
    return PostId(
      json['id'] as String,
    );
  }
  final String id;
}

enum RecipientKind { direct, group }

class Recipient {
  const Recipient(
    this.kind,
    this.value,
  );
  factory Recipient.fromJson(String data) {
    final json = jsonDecode(data);
    return Recipient(
      json['kind'] as RecipientKind,
      json['value'] as String,
    );
  }
  final String value;
  final RecipientKind kind;
}

enum PayloadKind { message, secret }

class Payload {
  const Payload(
    this.kind,
    this.value,
  );
  factory Payload.fromJson(String data) {
    final json = jsonDecode(data);
    return Payload(
      json['kind'] as PayloadKind,
      json['value'] as String,
    );
  }
  final String value;
  final PayloadKind kind;
}

class Post {
  const Post(
    this.to,
    this.payload,
    this.checksum,
    this.signature,
  );
  factory Post.fromJson(String data) {
    final json = jsonDecode(data);
    return Post(
      json['to'] as Recipient,
      json['payload'] as Payload,
      json['checksum'] as String,
      json['signature'] as String,
    );
  }
  final Recipient to;
  final Payload payload;
  final String checksum;
  final String signature;
}

class CompletePost {
  const CompletePost(
    this.id,
    this.genesis,
    this.expiry,
    this.owner,
    this.post,
  );
  factory CompletePost.fromJson(String data) {
    final json = jsonDecode(data);
    return CompletePost(
      json['id'] as String,
      json['genesis'] as int,
      json['expiry'] as int,
      json['owner'] as String,
      json['post'] as Post,
    );
  }
  final String id;
  final int genesis;
  final int expiry;
  final String owner;
  final Post post;
}

class DerivationIndex {
  const DerivationIndex(this.lastUsed);
  factory DerivationIndex.fromJson(String data) {
    final json = jsonDecode(data);
    return DerivationIndex(
      json['last_used'] as int,
    );
  }
  final int lastUsed;
}

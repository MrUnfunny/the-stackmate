class CypherPostHeader {
  CypherPostHeader({
    required this.pubKey,
    required this.nonce,
    required this.signature,
  });

  final String pubKey;
  final int nonce;
  final String signature;

  Map<String, dynamic> toDict() {
    return {
      'X-Client-Signature': signature,
      'X-Nonce': nonce,
      'X-Client-Pubkey': pubKey,
    };
  }
}

class CypherPostServerIdentity {
  CypherPostServerIdentity({
    required this.name,
    required this.pubkey,
  });

  final String name;
  final String pubkey;
}

class CypherPostIdentity {
  CypherPostIdentity({
    required this.genesis,
    required this.username,
    required this.pubkey,
  });

  final int genesis;
  final String username;
  final String pubkey;
}

class CypherPostBadge {
  CypherPostBadge({
    required this.genesis,
    required this.by,
    required this.to,
    required this.kind,
    required this.hash,
    required this.nonce,
    required this.signature,
  });

  final int genesis;
  final String by;
  final String to;
  final String kind;
  final String hash;
  final String nonce;
  final String signature;

  @override
  String toString() {
    return '$by:$to:$kind:$nonce';
  }
}

class PlainPost {
  PlainPost({
    required this.id,
    required this.genesis,
    required this.expiry,
    required this.owner,
    required this.post,
  });

  final String id;
  final int genesis;
  final int expiry;
  final String owner;
  final Post post;

  RecipientKind getRecipientKind() {
    return post.to.kind;
  }

  PayloadKind getPayloadKind() {
    return post.payload.kind;
  }
}

class Post {
  Post({
    required this.to,
    required this.payload,
    required this.checksum,
    required this.signature,
  });

  final Recipient to;
  final Payload payload;
  final String checksum;
  final String signature;
}

class Payload {
  Payload({
    required this.kind,
    required this.value,
  });

  final PayloadKind kind;
  final String value;
}

enum PayloadKind {
  preferences,
  message,
  secret,
}

enum RecipientKind {
  direct,
  group,
}

class Recipient {
  Recipient({
    required this.kind,
    required this.value,
  });

  final RecipientKind kind;
  final String value;
}

class ChatHistory {
  ChatHistory({
    required this.counterParty,
    required this.posts,
  });

  String counterParty;
  List<PlainPost> posts;
}

class AllChatHistory {
  AllChatHistory({
    required this.lastGenesis,
    required this.verified,
    required this.corrupted,
  });

  int lastGenesis;
  List<ChatHistory> verified;
  List<String> corrupted;
}

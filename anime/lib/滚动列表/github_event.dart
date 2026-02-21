import 'package:json_annotation/json_annotation.dart';

part 'github_event.g.dart';

@JsonSerializable()
class GithubEvent {
  final String id;
  final String type;
  final Actor actor;
  final Repo repo;
  final Payload payload;
  final bool public;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final Org? org;

  GithubEvent({
    required this.id,
    required this.type,
    required this.actor,
    required this.repo,
    required this.payload,
    required this.public,
    required this.createdAt,
    this.org,
  });

  factory GithubEvent.fromJson(Map<String, dynamic> json) =>
      _$GithubEventFromJson(json);

  Map<String, dynamic> toJson() => _$GithubEventToJson(this);
}

@JsonSerializable()
class Actor {
  final int id;
  final String login;

  @JsonKey(name: 'display_login')
  final String displayLogin;

  @JsonKey(name: 'gravatar_id')
  final String gravatarId;

  final String url;

  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Actor({
    required this.id,
    required this.login,
    required this.displayLogin,
    required this.gravatarId,
    required this.url,
    required this.avatarUrl,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  Map<String, dynamic> toJson() => _$ActorToJson(this);
}

@JsonSerializable()
class Repo {
  final int id;
  final String name;
  final String url;

  Repo({required this.id, required this.name, required this.url});

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}

@JsonSerializable()
class Payload {
  @JsonKey(name: 'repository_id')
  final int? repositoryId;

  @JsonKey(name: 'push_id')
  final int? pushId;

  final String? ref;
  final String? head;
  final String? before;

  @JsonKey(name: 'ref_type')
  final String? refType;

  @JsonKey(name: 'full_ref')
  final String? fullRef;

  @JsonKey(name: 'master_branch')
  final String? masterBranch;

  final String? description;

  @JsonKey(name: 'pusher_type')
  final String? pusherType;

  Payload({
    this.repositoryId,
    this.pushId,
    this.ref,
    this.head,
    this.before,
    this.refType,
    this.fullRef,
    this.masterBranch,
    this.description,
    this.pusherType,
  });

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}

@JsonSerializable()
class Org {
  final int id;
  final String login;

  @JsonKey(name: 'gravatar_id')
  final String gravatarId;

  final String url;

  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  Org({
    required this.id,
    required this.login,
    required this.gravatarId,
    required this.url,
    required this.avatarUrl,
  });

  factory Org.fromJson(Map<String, dynamic> json) => _$OrgFromJson(json);

  Map<String, dynamic> toJson() => _$OrgToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubEvent _$GithubEventFromJson(Map<String, dynamic> json) => GithubEvent(
  id: json['id'] as String,
  type: json['type'] as String,
  actor: Actor.fromJson(json['actor'] as Map<String, dynamic>),
  repo: Repo.fromJson(json['repo'] as Map<String, dynamic>),
  payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
  public: json['public'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  org: json['org'] == null
      ? null
      : Org.fromJson(json['org'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GithubEventToJson(GithubEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'payload': instance.payload,
      'public': instance.public,
      'created_at': instance.createdAt.toIso8601String(),
      'org': instance.org,
    };

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  displayLogin: json['display_login'] as String,
  gravatarId: json['gravatar_id'] as String,
  url: json['url'] as String,
  avatarUrl: json['avatar_url'] as String,
);

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'display_login': instance.displayLogin,
  'gravatar_id': instance.gravatarId,
  'url': instance.url,
  'avatar_url': instance.avatarUrl,
};

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
};

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
  repositoryId: (json['repository_id'] as num?)?.toInt(),
  pushId: (json['push_id'] as num?)?.toInt(),
  ref: json['ref'] as String?,
  head: json['head'] as String?,
  before: json['before'] as String?,
  refType: json['ref_type'] as String?,
  fullRef: json['full_ref'] as String?,
  masterBranch: json['master_branch'] as String?,
  description: json['description'] as String?,
  pusherType: json['pusher_type'] as String?,
);

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'repository_id': instance.repositoryId,
  'push_id': instance.pushId,
  'ref': instance.ref,
  'head': instance.head,
  'before': instance.before,
  'ref_type': instance.refType,
  'full_ref': instance.fullRef,
  'master_branch': instance.masterBranch,
  'description': instance.description,
  'pusher_type': instance.pusherType,
};

Org _$OrgFromJson(Map<String, dynamic> json) => Org(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  gravatarId: json['gravatar_id'] as String,
  url: json['url'] as String,
  avatarUrl: json['avatar_url'] as String,
);

Map<String, dynamic> _$OrgToJson(Org instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'gravatar_id': instance.gravatarId,
  'url': instance.url,
  'avatar_url': instance.avatarUrl,
};

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'clip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AudioClip _$AudioClipFromJson(Map<String, dynamic> json) {
  return _AudioClip.fromJson(json);
}

/// @nodoc
mixin _$AudioClip {
  String get episodeTitle => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioClipCopyWith<AudioClip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioClipCopyWith<$Res> {
  factory $AudioClipCopyWith(AudioClip value, $Res Function(AudioClip) then) =
      _$AudioClipCopyWithImpl<$Res>;
  $Res call(
      {String episodeTitle,
      String thumbnail,
      String name,
      String url,
      String id,
      Duration duration});
}

/// @nodoc
class _$AudioClipCopyWithImpl<$Res> implements $AudioClipCopyWith<$Res> {
  _$AudioClipCopyWithImpl(this._value, this._then);

  final AudioClip _value;
  // ignore: unused_field
  final $Res Function(AudioClip) _then;

  @override
  $Res call({
    Object? episodeTitle = freezed,
    Object? thumbnail = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? id = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      episodeTitle: episodeTitle == freezed
          ? _value.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$$_AudioClipCopyWith<$Res> implements $AudioClipCopyWith<$Res> {
  factory _$$_AudioClipCopyWith(
          _$_AudioClip value, $Res Function(_$_AudioClip) then) =
      __$$_AudioClipCopyWithImpl<$Res>;
  @override
  $Res call(
      {String episodeTitle,
      String thumbnail,
      String name,
      String url,
      String id,
      Duration duration});
}

/// @nodoc
class __$$_AudioClipCopyWithImpl<$Res> extends _$AudioClipCopyWithImpl<$Res>
    implements _$$_AudioClipCopyWith<$Res> {
  __$$_AudioClipCopyWithImpl(
      _$_AudioClip _value, $Res Function(_$_AudioClip) _then)
      : super(_value, (v) => _then(v as _$_AudioClip));

  @override
  _$_AudioClip get _value => super._value as _$_AudioClip;

  @override
  $Res call({
    Object? episodeTitle = freezed,
    Object? thumbnail = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? id = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_AudioClip(
      episodeTitle: episodeTitle == freezed
          ? _value.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AudioClip implements _AudioClip {
  _$_AudioClip(
      {required this.episodeTitle,
      required this.thumbnail,
      required this.name,
      required this.url,
      required this.id,
      required this.duration});

  factory _$_AudioClip.fromJson(Map<String, dynamic> json) =>
      _$$_AudioClipFromJson(json);

  @override
  final String episodeTitle;
  @override
  final String thumbnail;
  @override
  final String name;
  @override
  final String url;
  @override
  final String id;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'AudioClip(episodeTitle: $episodeTitle, thumbnail: $thumbnail, name: $name, url: $url, id: $id, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioClip &&
            const DeepCollectionEquality()
                .equals(other.episodeTitle, episodeTitle) &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodeTitle),
      const DeepCollectionEquality().hash(thumbnail),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$$_AudioClipCopyWith<_$_AudioClip> get copyWith =>
      __$$_AudioClipCopyWithImpl<_$_AudioClip>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AudioClipToJson(
      this,
    );
  }
}

abstract class _AudioClip implements AudioClip {
  factory _AudioClip(
      {required final String episodeTitle,
      required final String thumbnail,
      required final String name,
      required final String url,
      required final String id,
      required final Duration duration}) = _$_AudioClip;

  factory _AudioClip.fromJson(Map<String, dynamic> json) =
      _$_AudioClip.fromJson;

  @override
  String get episodeTitle;
  @override
  String get thumbnail;
  @override
  String get name;
  @override
  String get url;
  @override
  String get id;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$_AudioClipCopyWith<_$_AudioClip> get copyWith =>
      throw _privateConstructorUsedError;
}

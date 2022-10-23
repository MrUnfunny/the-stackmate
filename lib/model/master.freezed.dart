// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'master.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MasterKey {
  @HiveField(0)
  String? get seed => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get passphrase => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get root => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get fingerprint => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get network => throw _privateConstructorUsedError;
  @HiveField(5)
  bool? get hasPassphrase => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MasterKeyCopyWith<MasterKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MasterKeyCopyWith<$Res> {
  factory $MasterKeyCopyWith(MasterKey value, $Res Function(MasterKey) then) =
      _$MasterKeyCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String? seed,
      @HiveField(1) String? passphrase,
      @HiveField(2) String? root,
      @HiveField(3) String? fingerprint,
      @HiveField(4) String? network,
      @HiveField(5) bool? hasPassphrase});
}

/// @nodoc
class _$MasterKeyCopyWithImpl<$Res> implements $MasterKeyCopyWith<$Res> {
  _$MasterKeyCopyWithImpl(this._value, this._then);

  final MasterKey _value;
  // ignore: unused_field
  final $Res Function(MasterKey) _then;

  @override
  $Res call({
    Object? seed = freezed,
    Object? passphrase = freezed,
    Object? root = freezed,
    Object? fingerprint = freezed,
    Object? network = freezed,
    Object? hasPassphrase = freezed,
  }) {
    return _then(_value.copyWith(
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String?,
      passphrase: passphrase == freezed
          ? _value.passphrase
          : passphrase // ignore: cast_nullable_to_non_nullable
              as String?,
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as String?,
      fingerprint: fingerprint == freezed
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String?,
      network: network == freezed
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      hasPassphrase: hasPassphrase == freezed
          ? _value.hasPassphrase
          : hasPassphrase // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_MasterKeyCopyWith<$Res> implements $MasterKeyCopyWith<$Res> {
  factory _$$_MasterKeyCopyWith(
          _$_MasterKey value, $Res Function(_$_MasterKey) then) =
      __$$_MasterKeyCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String? seed,
      @HiveField(1) String? passphrase,
      @HiveField(2) String? root,
      @HiveField(3) String? fingerprint,
      @HiveField(4) String? network,
      @HiveField(5) bool? hasPassphrase});
}

/// @nodoc
class __$$_MasterKeyCopyWithImpl<$Res> extends _$MasterKeyCopyWithImpl<$Res>
    implements _$$_MasterKeyCopyWith<$Res> {
  __$$_MasterKeyCopyWithImpl(
      _$_MasterKey _value, $Res Function(_$_MasterKey) _then)
      : super(_value, (v) => _then(v as _$_MasterKey));

  @override
  _$_MasterKey get _value => super._value as _$_MasterKey;

  @override
  $Res call({
    Object? seed = freezed,
    Object? passphrase = freezed,
    Object? root = freezed,
    Object? fingerprint = freezed,
    Object? network = freezed,
    Object? hasPassphrase = freezed,
  }) {
    return _then(_$_MasterKey(
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String?,
      passphrase: passphrase == freezed
          ? _value.passphrase
          : passphrase // ignore: cast_nullable_to_non_nullable
              as String?,
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as String?,
      fingerprint: fingerprint == freezed
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String?,
      network: network == freezed
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      hasPassphrase: hasPassphrase == freezed
          ? _value.hasPassphrase
          : hasPassphrase // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 7, adapterName: 'MasterKeyClassAdapter')
class _$_MasterKey extends _MasterKey {
  const _$_MasterKey(
      {@HiveField(0) this.seed,
      @HiveField(1) this.passphrase,
      @HiveField(2) this.root,
      @HiveField(3) this.fingerprint,
      @HiveField(4) this.network,
      @HiveField(5) this.hasPassphrase})
      : super._();

  @override
  @HiveField(0)
  final String? seed;
  @override
  @HiveField(1)
  final String? passphrase;
  @override
  @HiveField(2)
  final String? root;
  @override
  @HiveField(3)
  final String? fingerprint;
  @override
  @HiveField(4)
  final String? network;
  @override
  @HiveField(5)
  final bool? hasPassphrase;

  @override
  String toString() {
    return 'MasterKey(seed: $seed, passphrase: $passphrase, root: $root, fingerprint: $fingerprint, network: $network, hasPassphrase: $hasPassphrase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MasterKey &&
            const DeepCollectionEquality().equals(other.seed, seed) &&
            const DeepCollectionEquality()
                .equals(other.passphrase, passphrase) &&
            const DeepCollectionEquality().equals(other.root, root) &&
            const DeepCollectionEquality()
                .equals(other.fingerprint, fingerprint) &&
            const DeepCollectionEquality().equals(other.network, network) &&
            const DeepCollectionEquality()
                .equals(other.hasPassphrase, hasPassphrase));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seed),
      const DeepCollectionEquality().hash(passphrase),
      const DeepCollectionEquality().hash(root),
      const DeepCollectionEquality().hash(fingerprint),
      const DeepCollectionEquality().hash(network),
      const DeepCollectionEquality().hash(hasPassphrase));

  @JsonKey(ignore: true)
  @override
  _$$_MasterKeyCopyWith<_$_MasterKey> get copyWith =>
      __$$_MasterKeyCopyWithImpl<_$_MasterKey>(this, _$identity);
}

abstract class _MasterKey extends MasterKey {
  const factory _MasterKey(
      {@HiveField(0) final String? seed,
      @HiveField(1) final String? passphrase,
      @HiveField(2) final String? root,
      @HiveField(3) final String? fingerprint,
      @HiveField(4) final String? network,
      @HiveField(5) final bool? hasPassphrase}) = _$_MasterKey;
  const _MasterKey._() : super._();

  @override
  @HiveField(0)
  String? get seed => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String? get passphrase => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  String? get root => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  String? get fingerprint => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  String? get network => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  bool? get hasPassphrase => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MasterKeyCopyWith<_$_MasterKey> get copyWith =>
      throw _privateConstructorUsedError;
}

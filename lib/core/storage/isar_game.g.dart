// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_game.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarGameCollection on Isar {
  IsarCollection<IsarGame> get isarGames => this.collection();
}

const IsarGameSchema = CollectionSchema(
  name: r'IsarGame',
  id: 6521419370899939680,
  properties: {
    r'activityName': PropertySchema(
      id: 0,
      name: r'activityName',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdBy': PropertySchema(
      id: 2,
      name: r'createdBy',
      type: IsarType.string,
    ),
    r'currentPlayerIndex': PropertySchema(
      id: 3,
      name: r'currentPlayerIndex',
      type: IsarType.long,
    ),
    r'currentStep': PropertySchema(
      id: 4,
      name: r'currentStep',
      type: IsarType.long,
    ),
    r'currentVotingTurnIndex': PropertySchema(
      id: 5,
      name: r'currentVotingTurnIndex',
      type: IsarType.long,
    ),
    r'finishedAt': PropertySchema(
      id: 6,
      name: r'finishedAt',
      type: IsarType.dateTime,
    ),
    r'gameId': PropertySchema(
      id: 7,
      name: r'gameId',
      type: IsarType.string,
    ),
    r'isTie': PropertySchema(
      id: 8,
      name: r'isTie',
      type: IsarType.bool,
    ),
    r'playersCount': PropertySchema(
      id: 9,
      name: r'playersCount',
      type: IsarType.long,
    ),
    r'playersJson': PropertySchema(
      id: 10,
      name: r'playersJson',
      type: IsarType.string,
    ),
    r'resultsJson': PropertySchema(
      id: 11,
      name: r'resultsJson',
      type: IsarType.string,
    ),
    r'stage': PropertySchema(
      id: 12,
      name: r'stage',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 13,
      name: r'status',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 14,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'winnerAnswer': PropertySchema(
      id: 15,
      name: r'winnerAnswer',
      type: IsarType.string,
    )
  },
  estimateSize: _isarGameEstimateSize,
  serialize: _isarGameSerialize,
  deserialize: _isarGameDeserialize,
  deserializeProp: _isarGameDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'gameId': IndexSchema(
      id: -1012023815008531514,
      name: r'gameId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'gameId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarGameGetId,
  getLinks: _isarGameGetLinks,
  attach: _isarGameAttach,
  version: '3.1.0+1',
);

int _isarGameEstimateSize(
  IsarGame object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activityName.length * 3;
  bytesCount += 3 + object.createdBy.length * 3;
  bytesCount += 3 + object.gameId.length * 3;
  bytesCount += 3 + object.playersJson.length * 3;
  bytesCount += 3 + object.resultsJson.length * 3;
  bytesCount += 3 + object.stage.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.winnerAnswer.length * 3;
  return bytesCount;
}

void _isarGameSerialize(
  IsarGame object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityName);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.createdBy);
  writer.writeLong(offsets[3], object.currentPlayerIndex);
  writer.writeLong(offsets[4], object.currentStep);
  writer.writeLong(offsets[5], object.currentVotingTurnIndex);
  writer.writeDateTime(offsets[6], object.finishedAt);
  writer.writeString(offsets[7], object.gameId);
  writer.writeBool(offsets[8], object.isTie);
  writer.writeLong(offsets[9], object.playersCount);
  writer.writeString(offsets[10], object.playersJson);
  writer.writeString(offsets[11], object.resultsJson);
  writer.writeString(offsets[12], object.stage);
  writer.writeString(offsets[13], object.status);
  writer.writeDateTime(offsets[14], object.updatedAt);
  writer.writeString(offsets[15], object.winnerAnswer);
}

IsarGame _isarGameDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarGame();
  object.activityName = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.createdBy = reader.readString(offsets[2]);
  object.currentPlayerIndex = reader.readLong(offsets[3]);
  object.currentStep = reader.readLong(offsets[4]);
  object.currentVotingTurnIndex = reader.readLong(offsets[5]);
  object.finishedAt = reader.readDateTimeOrNull(offsets[6]);
  object.gameId = reader.readString(offsets[7]);
  object.isTie = reader.readBool(offsets[8]);
  object.isarId = id;
  object.playersCount = reader.readLong(offsets[9]);
  object.playersJson = reader.readString(offsets[10]);
  object.resultsJson = reader.readString(offsets[11]);
  object.stage = reader.readString(offsets[12]);
  object.status = reader.readString(offsets[13]);
  object.updatedAt = reader.readDateTime(offsets[14]);
  object.winnerAnswer = reader.readString(offsets[15]);
  return object;
}

P _isarGameDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDateTime(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarGameGetId(IsarGame object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _isarGameGetLinks(IsarGame object) {
  return [];
}

void _isarGameAttach(IsarCollection<dynamic> col, Id id, IsarGame object) {
  object.isarId = id;
}

extension IsarGameByIndex on IsarCollection<IsarGame> {
  Future<IsarGame?> getByGameId(String gameId) {
    return getByIndex(r'gameId', [gameId]);
  }

  IsarGame? getByGameIdSync(String gameId) {
    return getByIndexSync(r'gameId', [gameId]);
  }

  Future<bool> deleteByGameId(String gameId) {
    return deleteByIndex(r'gameId', [gameId]);
  }

  bool deleteByGameIdSync(String gameId) {
    return deleteByIndexSync(r'gameId', [gameId]);
  }

  Future<List<IsarGame?>> getAllByGameId(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'gameId', values);
  }

  List<IsarGame?> getAllByGameIdSync(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'gameId', values);
  }

  Future<int> deleteAllByGameId(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'gameId', values);
  }

  int deleteAllByGameIdSync(List<String> gameIdValues) {
    final values = gameIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'gameId', values);
  }

  Future<Id> putByGameId(IsarGame object) {
    return putByIndex(r'gameId', object);
  }

  Id putByGameIdSync(IsarGame object, {bool saveLinks = true}) {
    return putByIndexSync(r'gameId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGameId(List<IsarGame> objects) {
    return putAllByIndex(r'gameId', objects);
  }

  List<Id> putAllByGameIdSync(List<IsarGame> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'gameId', objects, saveLinks: saveLinks);
  }
}

extension IsarGameQueryWhereSort on QueryBuilder<IsarGame, IsarGame, QWhere> {
  QueryBuilder<IsarGame, IsarGame, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarGameQueryWhere on QueryBuilder<IsarGame, IsarGame, QWhereClause> {
  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> gameIdEqualTo(
      String gameId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'gameId',
        value: [gameId],
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterWhereClause> gameIdNotEqualTo(
      String gameId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [],
              upper: [gameId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [gameId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [gameId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gameId',
              lower: [],
              upper: [gameId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarGameQueryFilter
    on QueryBuilder<IsarGame, IsarGame, QFilterCondition> {
  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> activityNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      activityNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> activityNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> activityNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      activityNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> activityNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> activityNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> activityNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      activityNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      activityNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> createdByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      createdByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentPlayerIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentPlayerIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentPlayerIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentPlayerIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentPlayerIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentPlayerIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentPlayerIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentPlayerIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> currentStepEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStep',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentStepGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStep',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> currentStepLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStep',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> currentStepBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentVotingTurnIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentVotingTurnIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentVotingTurnIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentVotingTurnIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentVotingTurnIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentVotingTurnIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      currentVotingTurnIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentVotingTurnIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> finishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      finishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> finishedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> finishedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> finishedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> finishedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gameId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gameId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gameId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gameId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> gameIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gameId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> isTieEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTie',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playersCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      playersCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playersCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playersCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playersCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      playersJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playersJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playersJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> playersJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playersJson',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      playersJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playersJson',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resultsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      resultsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resultsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resultsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resultsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'resultsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'resultsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'resultsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'resultsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> resultsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resultsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      resultsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'resultsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stage',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> stageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stage',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> winnerAnswerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winnerAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      winnerAnswerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'winnerAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> winnerAnswerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'winnerAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> winnerAnswerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'winnerAnswer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      winnerAnswerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'winnerAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> winnerAnswerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'winnerAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> winnerAnswerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'winnerAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition> winnerAnswerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'winnerAnswer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      winnerAnswerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winnerAnswer',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterFilterCondition>
      winnerAnswerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'winnerAnswer',
        value: '',
      ));
    });
  }
}

extension IsarGameQueryObject
    on QueryBuilder<IsarGame, IsarGame, QFilterCondition> {}

extension IsarGameQueryLinks
    on QueryBuilder<IsarGame, IsarGame, QFilterCondition> {}

extension IsarGameQuerySortBy on QueryBuilder<IsarGame, IsarGame, QSortBy> {
  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByActivityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByActivityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCreatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCreatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCurrentPlayerIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPlayerIndex', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy>
      sortByCurrentPlayerIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPlayerIndex', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCurrentStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByCurrentStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy>
      sortByCurrentVotingTurnIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVotingTurnIndex', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy>
      sortByCurrentVotingTurnIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVotingTurnIndex', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByGameIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByIsTie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTie', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByIsTieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTie', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByPlayersCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersCount', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByPlayersCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersCount', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByPlayersJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersJson', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByPlayersJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersJson', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByResultsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultsJson', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByResultsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultsJson', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByWinnerAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerAnswer', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> sortByWinnerAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerAnswer', Sort.desc);
    });
  }
}

extension IsarGameQuerySortThenBy
    on QueryBuilder<IsarGame, IsarGame, QSortThenBy> {
  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByActivityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByActivityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCreatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCreatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCurrentPlayerIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPlayerIndex', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy>
      thenByCurrentPlayerIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPlayerIndex', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCurrentStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByCurrentStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy>
      thenByCurrentVotingTurnIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVotingTurnIndex', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy>
      thenByCurrentVotingTurnIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVotingTurnIndex', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByGameIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByIsTie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTie', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByIsTieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTie', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByPlayersCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersCount', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByPlayersCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersCount', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByPlayersJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersJson', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByPlayersJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playersJson', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByResultsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultsJson', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByResultsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultsJson', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByWinnerAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerAnswer', Sort.asc);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QAfterSortBy> thenByWinnerAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerAnswer', Sort.desc);
    });
  }
}

extension IsarGameQueryWhereDistinct
    on QueryBuilder<IsarGame, IsarGame, QDistinct> {
  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByActivityName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByCreatedBy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByCurrentPlayerIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentPlayerIndex');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByCurrentStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStep');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct>
      distinctByCurrentVotingTurnIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentVotingTurnIndex');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedAt');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByGameId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gameId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByIsTie() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTie');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByPlayersCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playersCount');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByPlayersJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playersJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByResultsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resultsJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByStage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<IsarGame, IsarGame, QDistinct> distinctByWinnerAnswer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'winnerAnswer', caseSensitive: caseSensitive);
    });
  }
}

extension IsarGameQueryProperty
    on QueryBuilder<IsarGame, IsarGame, QQueryProperty> {
  QueryBuilder<IsarGame, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> activityNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityName');
    });
  }

  QueryBuilder<IsarGame, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> createdByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdBy');
    });
  }

  QueryBuilder<IsarGame, int, QQueryOperations> currentPlayerIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentPlayerIndex');
    });
  }

  QueryBuilder<IsarGame, int, QQueryOperations> currentStepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStep');
    });
  }

  QueryBuilder<IsarGame, int, QQueryOperations>
      currentVotingTurnIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentVotingTurnIndex');
    });
  }

  QueryBuilder<IsarGame, DateTime?, QQueryOperations> finishedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedAt');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> gameIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gameId');
    });
  }

  QueryBuilder<IsarGame, bool, QQueryOperations> isTieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTie');
    });
  }

  QueryBuilder<IsarGame, int, QQueryOperations> playersCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playersCount');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> playersJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playersJson');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> resultsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resultsJson');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> stageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stage');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<IsarGame, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<IsarGame, String, QQueryOperations> winnerAnswerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'winnerAnswer');
    });
  }
}

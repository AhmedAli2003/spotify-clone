class PaginationDto {
  final int? page;
  final int? limit;

  const PaginationDto({this.page, this.limit});

  /// Convert to a Map for Retrofit `@Queries()`
  Map<String, dynamic> toQuery() {
    final map = <String, dynamic>{};
    if (page != null) map['page'] = page;
    if (limit != null) map['limit'] = limit;
    return map;
  }

  PaginationDto copyWith({
    int? page,
    int? limit,
  }) {
    return PaginationDto(
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  @override
  String toString() => 'PaginationDto(page: $page, limit: $limit)';

  @override
  bool operator ==(covariant PaginationDto other) {
    if (identical(this, other)) return true;

    return other.page == page && other.limit == limit;
  }

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;
}

enum GridSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

class GridTokenValues {
  final GridSize name;
  final int startBreakpoint;
  final int endBreakpoint;
  final int columnCount;
  final double columnGap;
  final double columnMargin;
  final int fixedBodySize;

  const GridTokenValues({
    required this.name,
    required this.startBreakpoint,
    required this.endBreakpoint,
    required this.columnCount,
    required this.columnGap,
    required this.columnMargin,
    required this.fixedBodySize,
  });
}

abstract class GridTokens {
  GridTokenValues get xs;
  GridTokenValues get sm;
  GridTokenValues get md;
  GridTokenValues get lg;
  GridTokenValues get xl;
}

const Set<GridTokenValues> allGrids = {
  GridTokenValues(
    name: GridSize.xs,
    startBreakpoint: 0,
    endBreakpoint: 479,
    columnCount: 2,
    columnGap: 16,
    columnMargin: 24,
    fixedBodySize: -1,
  ),
  GridTokenValues(
    name: GridSize.sm,
    startBreakpoint: 480,
    endBreakpoint: 739,
    columnCount: 4,
    columnGap: 16,
    columnMargin: 32,
    fixedBodySize: -1,
  ),
  GridTokenValues(
    name: GridSize.md,
    startBreakpoint: 740,
    endBreakpoint: 979,
    columnCount: 6,
    columnGap: 24,
    columnMargin: 32,
    fixedBodySize: -1,
  ),
  GridTokenValues(
    name: GridSize.lg,
    startBreakpoint: 980,
    endBreakpoint: 1299,
    columnCount: 12,
    columnGap: 24,
    columnMargin: 64,
    fixedBodySize: -1,
  ),
  GridTokenValues(
    name: GridSize.xl,
    startBreakpoint: 1300,
    endBreakpoint: 99999,
    columnCount: 12,
    columnGap: 24,
    columnMargin: 76,
    fixedBodySize: 1176,
  )
};

class DefaultGridTokens extends GridTokens {
  @override
  GridTokenValues get xs =>
      allGrids.singleWhere((grid) => grid.name == GridSize.xs);
  @override
  GridTokenValues get sm =>
      allGrids.singleWhere((grid) => grid.name == GridSize.sm);
  @override
  GridTokenValues get md =>
      allGrids.singleWhere((grid) => grid.name == GridSize.md);
  @override
  GridTokenValues get lg =>
      allGrids.singleWhere((grid) => grid.name == GridSize.lg);
  @override
  GridTokenValues get xl =>
      allGrids.singleWhere((grid) => grid.name == GridSize.xl);
}

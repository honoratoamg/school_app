abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

class DatasourceError implements FailureSearch {}

class AlunoIsMatriculatedError implements FailureSearch {}
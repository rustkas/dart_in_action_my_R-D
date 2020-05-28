class Role {
  final String name;
  final int accessLevel;
  const Role(this.name, this.accessLevel);

  bool operator >(Role other) {
    return accessLevel > other.accessLevel;
  }

  bool operator <(Role other) {
    return accessLevel < other.accessLevel;
  }

  bool operator >=(Role other) {
    return accessLevel >= other.accessLevel;
  }

  bool operator <=(Role other) {
    return accessLevel <= other.accessLevel;
  }

  @override
  bool operator ==(other) {
    if (other is! Role) {
      return false;
    }
    return accessLevel == (other as Role).accessLevel;
  }

  @override
  int get hashCode {
    return accessLevel.hashCode;
  }

  static const Role timesheet_admin = Role('TIMESHEET_ADMIN', 3);
  static const Role timesheet_reporter = Role('TIMESHEET_REPORTER', 2);
  static const Role timesheet_user = Role('TIMESHEET_USER', 1);
}

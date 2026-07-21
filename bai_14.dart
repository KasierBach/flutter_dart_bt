enum Status { pending, approved, rejected, done }

extension StatusExtension on Status {
  String getDisplayName() {
    switch (this) {
      case Status.pending:
        return 'Đang chờ';
      case Status.approved:
        return 'Đã duyệt';
      case Status.rejected:
        return 'Đã từ chối';
      case Status.done:
        return 'Hoàn thành';
    }
  }

  bool isCompleted() {
    return this == Status.done;
  }
}

void main() {
  for (final Status status in Status.values) {
    print('${status.name}: ${status.getDisplayName()}');
    print('Đã hoàn thành: ${status.isCompleted()}\n');
  }
}

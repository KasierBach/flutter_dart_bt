class Student {
  Student({required this.name, required this.score, required this.major});

  final String name;
  final double score;
  final String major;
}

void main() {
  final List<Student> students = <Student>[
    Student(name: 'An', score: 8.5, major: 'CNTT'),
    Student(name: 'Bình', score: 7.2, major: 'CNTT'),
    Student(name: 'Chi', score: 9.1, major: 'CNTT'),
    Student(name: 'Dũng', score: 8.8, major: 'Kinh tế'),
    Student(name: 'Hà', score: 8.9, major: 'CNTT'),
    Student(name: 'Lan', score: 8.2, major: 'CNTT'),
  ];

  // where tạo danh sách chỉ gồm sinh viên thỏa điều kiện.
  final List<Student> qualifiedStudents = students
      .where(
        (Student student) => student.major == 'CNTT' && student.score >= 8.0,
      )
      .toList();

  // sort thay đổi trực tiếp thứ tự của qualifiedStudents.
  qualifiedStudents.sort(
    (Student first, Student second) => second.score.compareTo(first.score),
  );

  final List<String> topThreeNames = qualifiedStudents
      .take(3)
      .map((Student student) => student.name)
      .toList();

  final double totalScore = students
      .map((Student student) => student.score)
      .reduce((double total, double score) => total + score);
  final double averageScore = totalScore / students.length;

  print('Top 3 sinh viên CNTT có điểm từ 8.0: $topThreeNames');
  print('Điểm trung bình của cả lớp: ${averageScore.toStringAsFixed(2)}');
}

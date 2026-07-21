class Stack<T> {
  final List<T> _items = <T>[];

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (isEmpty()) {
      throw StateError('Không thể pop vì Stack đang rỗng.');
    }

    return _items.removeLast();
  }

  T peek() {
    if (isEmpty()) {
      throw StateError('Không thể peek vì Stack đang rỗng.');
    }

    return _items.last;
  }

  bool isEmpty() {
    return _items.isEmpty;
  }

  int size() {
    return _items.length;
  }
}

void main() {
  final Stack<int> numberStack = Stack<int>();

  numberStack.push(10);
  numberStack.push(20);
  numberStack.push(30);

  print('Số phần tử: ${numberStack.size()}');
  print('Phần tử trên đỉnh: ${numberStack.peek()}');
  print('Lấy khỏi Stack: ${numberStack.pop()}');
  print('Phần tử trên đỉnh sau khi pop: ${numberStack.peek()}');
  print('Stack có rỗng không: ${numberStack.isEmpty()}');
}

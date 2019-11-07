import 'dart:html';

Iterable<String> thingsTodo() sync* {
  var actions = ['Walk', 'Wash', 'Feed'];
  var pets = ['cats', 'dogs'];

  for (var action in actions) {
    for (var pet in pets) {
      if (pet == 'cats' && action != 'Feed') continue;
      yield '$action the $pet';
    }
  }
}

void addTodoItem(UListElement list, String item) {
  if (item.isEmpty) {
    return;
  }
  print(item);

  var listElement = LIElement();
  listElement.text = item;
  list.children.add(listElement);
}

void processDeleteAll(UListElement list) {
  list.children.clear();
}

InputElement toDoInput;
UListElement todoList;

void render() {
  querySelector('#output').text = 'Hello Dart!';

  toDoInput = querySelector('#to-do-input');
  toDoInput.onBlur.listen((_) => addTodoItem(todoList, toDoInput.value));

  todoList = querySelector('#todolist');
  thingsTodo().forEach((item) => addTodoItem(todoList, item));
}

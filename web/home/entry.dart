import 'dart:convert';
import 'dart:html';
import 'dart:async';

Future<void> makeRequest(UListElement list) async {
  const path = 'https://dart.dev/f/portmanteaux.json';
  try {
    // Make the GET request
    // final jsonString = await HttpRequest.getString(path);
    // The request succeeded. Process the JSON.
    // processResponse(list, jsonString);
    final httpRequest = HttpRequest();
    httpRequest
      ..open('GET', path)
      ..onLoadEnd.listen((_) => requestComplete(list, httpRequest))
      ..send('');
  } catch (_) {
    print('Couldn\'t open $path');
    list.children.add(LIElement()..text = 'Request failed.');
  }
}

void processResponse(UListElement list, String jsonString) {
  for (final portmanteau in json.decode(jsonString)) {
    list.children.add(LIElement()..text = portmanteau);
  }
}

void requestComplete(UListElement list, HttpRequest request) {
  switch (request.status) {
    case 200:
      processResponse(list, request.responseText);
      return;
    default:
      final li = LIElement()..text = 'Request failed, status=${request.status}';
      list.children.add(li);
  }
}

void processDeleteAll(UListElement list) {
  list.children.clear();
}

InputElement toDoInput;
UListElement todoList;
UListElement wordList;
ButtonElement deleteAll;

void render() {
  querySelector('#output').text = 'Hello World!';

  wordList = querySelector('#wordList');
  querySelector('#getWords').onClick.listen((_) => makeRequest(wordList));
  querySelector('#deleteAll').onClick.listen((_) => processDeleteAll(wordList));
}

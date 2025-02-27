import 'package:core/widgets/markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Markdown', type: md.ZbjMarkdown, path: 'Core')
Widget buildBrandButtonUseCase(BuildContext context) {
  return SingleChildScrollView(
      child: md.ZbjMarkdown(
    content: context.knobs.string(
        label: 'Content',
        initialValue: '''
![alt text](https://images.squarespace-cdn.com/content/v1/6539344259748856f0c8d598/1698247778117-EYMTPOSLG01O4YTXZ2L1/Asset+1.png?format=1500w)
# Heading 1
## Heading 2
### Heading 3
Paragraph with some **bold text** and *italic text* and ~~some strikethrough text~~
|tables|work|
|------|----|
|too   |yay!|
- Ordered
- Lists
- Work
1. Numbered lists
1. Too
1. !!!
> blockquotes can be handy to emphasize some text
```js
{
  var text = "code blocks are supported but not formatted"
  console.log(text);
}
```
This is a ruler:

---

- [x] Make awesome stuff
- [ ] Update the website
- [ ] Contact the media

This paragraph and the next one
---section---
Should have some extra spacing because of the ---section--- marker

Gone camping! ⛺ Be back soon.

we can [link stuff](https://www.example.com) but that will require some more coding


''',
        maxLines: 25),
  ));
}

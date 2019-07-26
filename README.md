# flutter_dialpad

A phone dialer widget

## Getting Started

```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
            DialPad(
                backspaceButtonIconColor: Colors.red,
                makeCall: (number){
                    print(number);
                }
            )
        ),
    );
  }

```

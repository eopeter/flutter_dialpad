# flutter_dialpad_example

A phone dialer widget that can be added to any Flutter Application to enable ability to dial a number. This could be combined with a voip application to enable placing calls.

This is a purely Dart widget with no dependency on Android or iOS except for the flutter_dtmf package it uses for DTMF tone generation on pressing a button. You can turn it off my setting ```enableDtmf: false```

## Getting Started

```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
            DialPad(
                enableDtmf: true,
                backspaceButtonIconColor: Colors.red,
                makeCall: (number){
                    print(number);
                }
            )
        ),
    );
  }

```

## To Do
[Done] Add DTMF Tones
Support Localization
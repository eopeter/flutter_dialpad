# flutter_dialpad

A phone dialer widget that can be added to any Flutter Application to enable ability to dial a number. This could be combined with a voip application to enable placing calls.

This is a purely Dart widget with no dependency on Android or iOS.

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
## Screenshots

![iOS Screenshot](screenshots/screenshot1.png?raw=true "iOS Screenshot") | ![Android Screenshot](screenshots/screenshot2.png?raw=true "Android Screenshot")
|:---:|:---:|
| iOS Screenshot | Android Screenshot |

## To Do
* Add DTMF Tones
* Shrink Ouput to Fit
* Support for Local Numbers in Text Input Mask

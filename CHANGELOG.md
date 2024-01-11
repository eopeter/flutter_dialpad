## [1.1.1] - 2023-01-12

* Fix missing `keyPressed` event for individual keys pressed on the keypad.

## [1.1.0] - 2023-00-23

* Add custom keypad `keypad_generator`s with extensibility options.
* Add `DialButton`with (future release) custom `keypadButtonBuilder` for specific usecases.
* Refactor Flutter Dialpad with prebuilt UIs (iOS, metro theme styles).
* Add `hideBackSpace` option.
* Add `padding` fields for buttons & text input.
* Changed UI scaling from height-based to width/height (thousand'th) ratio.
* Add keyboard input (numpad, number row, including various phone keypad symbols & actions), see [DigitKey, ActionKey] keys.
* Add `callOnEnter` to "place call" on numpad keyboard action.
* Add clipboard copy from/paste to & copy to clipboard option.
* Add custom text size fields for dial, button and subtitle text
* Add `buttonType` button style, for circular-or-rectangle-styles.
* Update example with prebuilt UIs
* Custom `ScalingType` and `ScalingSize` allows for customizability with the scalar value when determining the text/widget size.
  * `ScalingType` determines how the viewport window dimensions are used
  * `ScalingSize` is an enum providing preset scalar values, allowing for more flexibility than the default `0.001`
  * `Scalable` mixin allows provides a `rescale` function returning the newly scaled widget/text sizes
  * `ScalableButton` provides inheritable scaling properties based on `MaterialButton`
* Add `copyToClipboard` custom widget builder for `PhoneTextInput`
* Add `dialButton` & `backspaceButton` padding
* Added default & button-specific `ScalingType` and `ScalingSize` options
* Add content padding for dial, backspace and keypad buttons
* Add customizing dial, backspace button color & sizes
* Add scale clamping as a percentage of icon/text size for improved UI/UX, with defaults to [0.2, 1.0]
* Added `hideBackspaceOnEmpty` to automatically hide backspace button when input is empty
* Added `onTextChanged` to capture input text changed as displayed in the `PhoneTextInput`
* Add `initialText`, `withNumber` properties to autofill `PhoneTextInput`

## [1.0.5] - 2023-02-08

* Add ability to hide DialButton subtitle text

## [1.0.4] - 2022-02-21

* Crash Fix

## [1.0.3] - 2022-01-20

* Add Key Press Event
* Dtmf Library Update

## [1.0.2] - 2022-01-20

* Bug Fixes

## [1.0.1] - 2021-05-01

* Migrate to Null Safety

## [1.0.0] - 2020-04-19

* Updated Example

## [0.0.6+2] - 2020-03-19

* Dependencies Update

## [0.0.6+1] - 2019-07-28

* Make Textfield for output readonly

## [0.0.6] - 2019-07-28

* Added Option to not animate dial button onTap

## [0.0.5] - 2019-07-27

* Fix issue where dial button event is not fired

## [0.0.4] - 2019-07-27

* Added DTMF Tone and Option to Turn it Off

## [0.0.3] - 2019-07-26

* Added Example and Overflow Bug Fix

## [0.0.2] - 2019-07-26

* Clean up code per pub.dev suggestions

## [0.0.1] - 2019-07-26

* Initial Release of the Flutter Dial Pad Widget

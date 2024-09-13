//
//  form_enum.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

// =============== Enum to hold Form Type =============== //

enum FormType {
  // Space
  emptySpace,

  // label
  label,

  // Buttons
  button,

  // Radion Buttons
  labelWithRadioButton,

  // Check Box
  labelWithCheckBoxButton,

// Other UI Components
  labelTitleValuePair,
  labelWithTextField,
}

// =============== Enum to hold Form Operation =============== //
enum FormOperation {
  resetFormObject,
  copyValue,

  hideFormObject,
  showFormObject,
  disableFormObject,
  enableFormObject,

  setFormObjectEditable,
  setFormObjectNonEditable,
  setFormObjectMandatory,
  setFormObjectNonMandatory,

  changeSectionTitle,
  hideFormSection,
  showFormSection,
  hideFormRow,
  showFormRow,

  changeValueList,
  updatePopoverValueList,

  getValueFromView,
  setValueFromView,
  updateViewOnValueChanged,

  copyValueInValidation,
  selectValueInPopoverListFromCode,
}

// =============== Enum to hold keyboard Type =============== //
enum KeyboardType {
  defaultType,
  numbersAndPunctuation,
  numberPad,
  phonePad,
  namePhonePad,
  emailAddress
}

// =============== Enum to hold Font Alignment  =============== //
enum UITextAlignment {
  left, // Align the text on the left edge of the container.
  right, // Align the text on the right edge of the container.
  center, // Align the text in the center of the container.
  justified, // Stretch lines of text that end with a soft line break to fill the width of the container.
  start, // Align the text on the leading edge of the container.
  end, // Align the text on the trailing edge of the container.
}

// =============== Enum to hold Form Border Type =============== //
enum FormBorderType {
  noBorder,
  allCorner,
}

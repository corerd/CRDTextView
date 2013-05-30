//
//  CRDTextView.h
//  CRDTextView
//
/*
 The MIT License
 
 Copyright (c) 2013 Corrado Ubezio
 https://github.com/corerd/
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

/*!
 CRDTextView Class Reference
 
 The `CRDTextView` class inherits from `UILabel` and implements a read-only
 text view adding some capabilities of a `UITextField` object:
 - `placeholder` and `secureText` text attributes;
 - ability to copy the `text` property value to the pasteboard.

 CREDITS
 -------
 `CRDTextView` improves the `CopyableLabel` subclass by mrueg at [Stack Overflow]
 ( http://stackoverflow.com/a/2168169 ).
 */

#import <UIKit/UIKit.h>

@interface CRDTextView : UILabel

/*!
 The string that is displayed when there is no other text in the text field.
 
 By default, this value is set to the `text` property initial value.
 The `placeholder` string is drawn using a 70% grey color.
 */
@property (nonatomic, strong) NSString *placeholder;

/*!
 Identifies whether the text object should hide the displayed text.
 
 This property is set to `NO` by default.
 Setting this property to `YES` creates a password-style text object,
 which hides the displayed text.
 */
@property (nonatomic, getter=isSecureText) BOOL secureText;

@end

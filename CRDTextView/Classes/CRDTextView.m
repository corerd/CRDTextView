//
//  CRDTextView.m
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

#import "CRDTextView.h"

@implementation CRDTextView
{
    UIColor *bgColor;
    UIColor *txtColor;
    NSString *roTextValue;
}

@synthesize secureText = _secureText;

#pragma mark -
#pragma mark Initialization code

// Override initWithFrame: if you add the UI object programmatically.
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

// Override initWithCoder: if you're loading UI object from a nib or storyboard.
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    
    return self;
}

// Common initialization code
- (void)commonInit
{
    _secureText = NO;
    bgColor = [self backgroundColor];
    txtColor = [self textColor];
    [self setPlaceholder:[self text]];
    [self setText:@""];
    
    // subscribe to UIMenuController state changes
    // to get notified when the system hides the menu:
    [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(dismissEditMenu:)
         name:UIMenuControllerWillHideMenuNotification
         object:nil];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


#pragma mark -
#pragma mark Accessor methods

- (void)setSecureText:(BOOL)hiddenText
{
    _secureText = hiddenText;
    [self setText:roTextValue];
}

- (void)setText:(NSString *)text
{
    roTextValue = text;
    NSString *txtToDisplay;
    if ([text isEqual:@""]) {
        // display default placeholder
        [self setTextColor:[UIColor lightGrayColor]];
        txtToDisplay = [self placeholder];
    }
    else {
        // diplay the password text in clear or hidden mode
        [self setTextColor:txtColor];
        if ([self isSecureText]) {
            // hidden mode: replace the password text with asterisks
            txtToDisplay = [@"" stringByPaddingToLength:[roTextValue length]
                                             withString:@"*"
                                        startingAtIndex:0];
        }
        else {
            // clear mode
            txtToDisplay = text;
        }
    }
    
    // prepends a blank character to fit better in the text field
    [super setText:[NSString stringWithFormat:@" %@", txtToDisplay]];
}


#pragma mark -
#pragma mark Menu commands and validation

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copy:)) {
        return YES;
    }
    else {
        return [super canPerformAction:action withSender:sender];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    if([super becomeFirstResponder]) {
        self.highlighted = YES;
        return YES;
    }
    return NO;
}

- (void)dismissEditMenu:(id)sender {
    self.highlighted = NO;
    [self resignFirstResponder];
}

- (void)copy:(id)sender {
    //[sender sendActionsForControlEvents:UIControlEventTouchUpInside];
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    [board setString:roTextValue];
    self.highlighted = NO;
    [self resignFirstResponder];
}

- (void)setHighlighted:(BOOL)highlighted
{
    // Thank's to `setHighlighted method override` by Mugunth
    // at [Stack Overflow]( http://stackoverflow.com/a/10670141 )
    if(highlighted) {
        float red, green, blue, alpha;
        [self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
        double multiplier = 0.8f;
        self.backgroundColor = [UIColor colorWithRed:red * multiplier
                                               green:green * multiplier
                                                blue:blue*multiplier
                                               alpha:alpha];
    } else {
        self.backgroundColor = bgColor;
    }
    [super setHighlighted:highlighted];
}

#pragma mark -
#pragma mark Touch handling

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self isFirstResponder]) {
        self.highlighted = NO;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuVisible:NO animated:YES];
        [menu update];
        [self resignFirstResponder];
    }
    else {
        if ([roTextValue isEqual:@""]) {
            return;
        }
        if([self becomeFirstResponder]) {
            UIMenuController *menu = [UIMenuController sharedMenuController];
            [menu setTargetRect:self.bounds inView:self];
            [menu setMenuVisible:YES animated:YES];
        }
    }
}

@end

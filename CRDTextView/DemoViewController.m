//
//  DemoViewController.m
//  Demo CRDTextView
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

#import "DemoViewController.h"

@interface DemoViewController ()

@end


#pragma mark -
#pragma mark Initialization code

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.switchReveal setOn:NO];
    [self.txtView setSecureText:YES];
    [self.txtView setText:[self.txtInput text]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Actions

- (IBAction)toggleReveal:(id)sender
{
    /*
     [[UIApplication sharedApplication] sendAction:@selector(selectAll:)
     to:self.txtReadOnly
     from:self
     forEvent:nil];
     */
    // toggle password reveal
    [self.txtView setSecureText:![self.txtView isSecureText]];
}


#pragma mark -
#pragma mark UITextFieldDelegate Protocols

/*
 - (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField
 {
 return YES;
 }
 */

/*
 - (void)textFieldDidBeginEditing:(UITextField *)theTextField
 {
 }
 */

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == [self txtInput]) {
        [self.txtView setText:[self.txtInput text]];
        [theTextField resignFirstResponder];
    }
    return YES;
}


@end

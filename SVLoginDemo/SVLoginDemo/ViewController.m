//
//  ViewController.m
//  SVLoginDemo
//
//  Created by Anton Gubarenko on 30.04.15.
//  Copyright (c) 2015 Anton Gubarenko. All rights reserved.
//

#import "ViewController.h"
#import "SVTextField.h"
#import "SVButton.h"

static const CGFloat kAnimationDuration = 0.3f;
static const CGFloat kAnimationEps = 0.1f;
static const CGFloat kButtonPadding = 20.0f;
static const CGFloat kButtonHeight = 50.0f;
static const CGFloat kButtonBottom = 79.0f;
static const CGFloat kSleepDelay = 3.0f;

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet SVTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet SVTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet SVButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBtnConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightbtnConstraint;

@end

@implementation ViewController

#pragma mark - View LifeCycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
    [self resetButton];
}

- (void) resetButton
{
    self.leftBtnConstraint.constant = kButtonPadding;
    self.rightBtnConstraint.constant = kButtonPadding;
    self.bottomBtnConstraint.constant = kButtonBottom;
    self.heightbtnConstraint.constant = kButtonHeight;
    [self.loginButton setTitle: NSLocalizedString(@"Sign Up", @"")
                      forState: UIControlStateNormal];
    [self.loginButton setAlpha: 1.0f];
}

#pragma mark - UITextField Delegate -

- (BOOL) textFieldShouldReturn: (UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing: (UITextField *) textField
{
    CGFloat offset = textField.frame.origin.y;
    [UIView animateWithDuration: kAnimationDuration
                     animations: ^{
                         CGRect frame = self.view.frame;
                         frame.origin.y = - (CGRectGetHeight(self.view.frame) - offset  - CGRectGetHeight(textField.frame));
                         self.view.frame = frame;
                     }];
}

- (void) textFieldDidEndEditing: (UITextField *) textField
{
    [UIView animateWithDuration: kAnimationDuration
                     animations: ^{
                         CGRect frame = self.view.frame;
                         frame.origin.y = 0.0f;
                         self.view.frame = frame;
                     }];
}

#pragma mark - Actions -

- (IBAction)loginAction: (id) sender
{
    [self loginInBackground];
}

- (void) loginInBackground
{
    [self.loginButton startActivity];
    [self resizeButton];
    dispatch_async( dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval: kSleepDelay];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self animateTransition];
        });
    });
}

- (void) resizeButton
{
    CGFloat padding = (CGRectGetWidth(self.view.frame) - [self.loginButton activeButtonWidth]) / 2.0;
    self.leftBtnConstraint.constant = padding;
    self.rightBtnConstraint.constant = padding;
    [UIView animateWithDuration: kAnimationDuration
                     animations: ^{
                         [self.view layoutIfNeeded];
                     }
                     completion: ^(BOOL finished)
     {
     }];
}

- (void) animateTransition
{
    [self.loginButton stopActivity];
    
    CGFloat scale = (CGRectGetHeight(self.view.frame) / CGRectGetHeight(self.loginButton.frame))* 2.0;
    [UIView animateWithDuration: kAnimationDuration
                     animations: ^{
                         [self.loginButton setTransform: CGAffineTransformMakeScale(scale, scale)];
                         self.loginButton.alpha = 0.0f;
                         [self.view layoutIfNeeded];
                     }
                     completion: ^(BOOL finished)
     {
     }];
    [self performSelector: @selector(navigateToiMain)
               withObject: nil
               afterDelay: kAnimationDuration - kAnimationEps];
}

- (void) navigateToiMain
{
    [self performSegueWithIdentifier: @"MainSegue"
                              sender: nil];
    [self.navigationController setNavigationBarHidden: NO];
}


@end

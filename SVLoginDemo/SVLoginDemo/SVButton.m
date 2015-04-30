//
//  SVButton.m
//  SVLoginDemo
//
//  Created by Anton Gubarenko on 30.04.15.
//  Copyright (c) 2015 Anton Gubarenko. All rights reserved.
//

#import "SVButton.h"

static const CGFloat kActivityHeight = 50.0f;
static const CGFloat kActivityPadding = 5.0f;

@interface SVButton ()

@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) NSString *titleCache;
@end

@implementation SVButton

#pragma mark - Init -

- (void) awakeFromNib
{
    [self setupLayout];
}

- (void) setupLayout
{
    [self.layer setCornerRadius: CGRectGetHeight(self.frame) / 2.0];
    [self setClipsToBounds: YES];
    [self addActivityIndicator];
}

- (void) addActivityIndicator
{   
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(kActivityPadding, 0, kActivityHeight, kActivityHeight)];
    self.activityView.backgroundColor = [UIColor clearColor];
    [self.activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityView setHidesWhenStopped: YES];
    [self addSubview: self.activityView];
}

#pragma mark - Methods -

- (void) startActivity
{
    [self.activityView startAnimating];
    self.titleCache = [self titleForState: UIControlStateNormal];
    [self setTitle: @""
          forState: UIControlStateNormal];
}

- (void) stopActivity
{
    [self.activityView stopAnimating];
}

- (CGFloat) activeButtonWidth
{
    return kActivityHeight * 2 - kActivityPadding * 2;
}

@end

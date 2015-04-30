//
//  SVTextField.m
//  SVLoginDemo
//
//  Created by Anton Gubarenko on 30.04.15.
//  Copyright (c) 2015 Anton Gubarenko. All rights reserved.
//

#import "SVTextField.h"

static const CGFloat kLineHeight = 1.0f;

@implementation SVTextField

#pragma mark - Init -

- (void) awakeFromNib
{
    [self setupLayout];
}

- (void) setupLayout
{
    [self setBorderStyle: UITextBorderStyleNone];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetHeight(self.frame) /2.0, CGRectGetHeight(self.frame) /2.0)];
    [leftImageView setImage: self.leftImage];
    [leftImageView setContentMode: UIViewContentModeScaleAspectFit];
    
    self.leftView = leftImageView;
    
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholderColor)
    {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString: self.placeholder
                                                                     attributes: @{NSForegroundColorAttributeName: self.placeholderColor}];
    }
    [self addLineToSubview];
}

- (void) addLineToSubview
{
    UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetHeight(self.frame) - kLineHeight, CGRectGetWidth(self.frame), kLineHeight)];
    [lineView setBackgroundColor: [UIColor whiteColor]];
    [lineView setAlpha: 0.3f];
    [self addSubview: lineView];
}

#pragma mark - Padding -

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + CGRectGetHeight(self.frame),
                      bounds.origin.y,
                      bounds.size.width - CGRectGetHeight(self.frame),
                      bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

@end

//
//  SVTextField.h
//  SVLoginDemo
//
//  Created by Anton Gubarenko on 30.04.15.
//  Copyright (c) 2015 Anton Gubarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface SVTextField : UITextField

@property (nonatomic, strong) IBInspectable UIImage *leftImage;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end

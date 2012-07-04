//
//  CalculatorViewController.h
//  Calculator
//
//  Created by William Krueger on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UITextView *history;
@property (weak, nonatomic) IBOutlet UILabel *statusDisplay;

@end

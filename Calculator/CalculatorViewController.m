//
//  CalculatorViewController.m
//  Calculator
//
//  Created by William Krueger on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL numberHasDecimalPointAlready;
@end

@implementation CalculatorViewController


@synthesize display = _display;
@synthesize history = _history;
@synthesize statusDisplay = _statusDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize numberHasDecimalPointAlready = _numberHasDecimalPointAlready;



-(CalculatorBrain *)brain
{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    NSLog(@"digit: %@", digit);
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];    
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    [self clearStatusDisplay];

}	

- (IBAction)actionPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    self.display.text = [[NSNumber numberWithDouble:[self.brain performOperation:sender.currentTitle]] stringValue];
    self.history.text = [CalculatorBrain descriptionOfProgram:self.brain.program];
    
}


- (IBAction)enterPressed{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.numberHasDecimalPointAlready = NO;
    self.history.text = [CalculatorBrain descriptionOfProgram:self.brain.program];
    self.statusDisplay.text = @"=";

    
}

- (IBAction)changeSignPressed {

    /*
     //leaving this in... as it's somewhat elegant... it just doesn't work with the next assignment (#2)
     // gotta do this without touching CalculatorBrain
     
    // I don't want to change any flags here... just negate the display.
    [self.brain pushOperand:[self.display.text doubleValue]];
    
    // performOperation:@"+/-" will pop the operand off stack, return a result... but won't add the result back on the stack.
    // ...so no one will be the wiser!
    self.display.text = [[NSNumber numberWithDouble:[self.brain performOperation:@"+/-"]] stringValue];
     
    */
    
    self.display.text = [[NSNumber numberWithDouble:([self.display.text doubleValue] * -1)] stringValue];
    self.statusDisplay.text = @"";
}

- (IBAction)clearPressed:(UIButton *)sender {
    self.display.text = @"0";
    [self.brain clear];
    self.history.text = @"";
    [self clearStatusDisplay];
}


- (IBAction)dotPushed {
    if (!self.numberHasDecimalPointAlready) {
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:@"."];            
        }
        else {
            self.display.text = @"0.";
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
        self.numberHasDecimalPointAlready = YES;
        [self clearStatusDisplay];
        
    }
    
}
- (IBAction)backspacePressed {
    if ((!self.userIsInTheMiddleOfEnteringANumber) || [self.display.text length] == 1) {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
        self.numberHasDecimalPointAlready = NO;
        
    }
    else {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
        self.numberHasDecimalPointAlready = ([self.display.text rangeOfString:@"."].length != 0);
    }
    [self clearStatusDisplay];
}

-(void)clearStatusDisplay
{
    self.statusDisplay.text = @"";
}

@end

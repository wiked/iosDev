//
//  CalculatorBrain.m
//  Calculator
//
//  Created by William Krueger on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}


-(void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}


-(double)popOperand
{
    NSNumber *result = [self.operandStack lastObject];
    if (result) {
        [self.operandStack removeLastObject];
    }
    
    return [result doubleValue];
}



-(double)performOperation:(NSString *)operation
{
    double result = 0;
    BOOL pushItemBackOnStack = YES;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];    
    }
    else if ([operation isEqualToString:@"-"]) {
        double subby = [self popOperand];
        result = [self popOperand] - subby;
    }
    else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"/"]) {
        double div = [self popOperand];
        result = [self popOperand] / div;
    }
    else if ([operation isEqualToString:@"√"])
    {
        result = sqrt([self popOperand]);
    }
    else if ([operation isEqualToString:@"sin"])
    {
        result = sin([self popOperand]);
    }
    else if ([operation isEqualToString:@"cos"])
    {
        result = cos([self popOperand]);
    }
    else if ([operation isEqualToString:@"π"])
    {
        result = M_PI;
    }
    else if ([operation isEqualToString:@"+/-"])
    {
        pushItemBackOnStack = NO;
        result = [self popOperand] * -1;
    }
    
    if (pushItemBackOnStack) {
        [self.operandStack addObject:[NSNumber numberWithDouble:result]];
    }
    
    return result;
}



-(void)clear
{
    [self.operandStack removeAllObjects];
}

-(NSString *)operationStackAsString
{
    NSString *result;
    
    for (NSNumber *num in self.operandStack) {
        if(result)
        {
            result = [result stringByAppendingFormat:@"\n%@",[num stringValue]]; 
        }
        else 
        {
            result = [num stringValue];
        }
    }
    
    return result;
}

@end

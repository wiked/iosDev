//
//  CalculatorBrain.m
//  Calculator
//
//  Created by William Krueger on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

-(id)program
{
    return [self.programStack copy];
}



+(double)runProgram:(id)program
{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

+(NSString *)descriptionOfProgram:(id)program
{
    NSArray *result;
    if ([program isKindOfClass:[NSArray class]]) {
        result = program;
    }
    return [result componentsJoinedByString:@"\n"];
}


-(NSMutableArray *)programStack
{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}


-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}


+(double)popOperandOffStack:(NSMutableArray*)stack
{
    /*
    NSNumber *result = [self.operandStack lastObject];
    if (result) {
        [self.operandStack removeLastObject];
    }
    
    return [result doubleValue];
     */
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) {
        [stack removeLastObject];
    }
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];    
        }
        else if ([operation isEqualToString:@"-"]) {
            double subby = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subby;
        }
        else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"/"]) {
            double div = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] / div;
        }
        else if ([operation isEqualToString:@"√"])
        {
            result = sqrt([self popOperandOffStack:stack]);
        }
        else if ([operation isEqualToString:@"sin"])
        {
            result = sin([self popOperandOffStack:stack]);
        }
        else if ([operation isEqualToString:@"cos"])
        {
            result = cos([self popOperandOffStack:stack]);
        }
        else if ([operation isEqualToString:@"π"])
        {
            result = M_PI;
        }
        
    }
    
    return result;
}



-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
    
}
    

-(void)clear
{
    [self.programStack removeAllObjects];
}


@end

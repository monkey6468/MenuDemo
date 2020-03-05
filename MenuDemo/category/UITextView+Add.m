//
//  UITextView+Add.m
//  MenuDemo
//
//  Created by HN on 2020/3/5.
//  Copyright © 2020 HN. All rights reserved.
//

#import "UITextView+Add.h"


@implementation UITextView (Add)

-(NSRange)selectedRange{
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    return NSMakeRange(location, length);
}

-(void)setSelectedRange:(NSRange)selectedRange{
    UITextPosition *startPosition = [self positionFromPosition:self.beginningOfDocument offset:selectedRange.location];
    UITextPosition *endPosition = [self positionFromPosition:self.beginningOfDocument offset:selectedRange.location + selectedRange.length];
    UITextRange *selectedTextRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectedTextRange];
}

@end

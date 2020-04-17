//
//  MyTextView.m
//  MenuDemo
//
//  Created by HN on 2020/4/17.
//  Copyright © 2020 HN. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (BOOL)hasText
{
    if ([self.myDelegate respondsToSelector:@selector(myTextViewHasText:)]) {
        return [self.myDelegate myTextViewHasText:self];
    }
    return NO;
}
- (void)insertText:(NSString *)text {
    
}
- (void)deleteBackward {
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end

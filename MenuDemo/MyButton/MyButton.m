//
//  MyButton.m
//  MenuDemo
//
//  Created by HN on 2020/4/17.
//  Copyright © 2020 HN. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (BOOL)hasText
{
    if ([self.myDelegate respondsToSelector:@selector(myButtonHasText:)]) {
        return [self.myDelegate myButtonHasText:self];
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

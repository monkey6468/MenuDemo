//
//  ListCell.m
//  MenuDemo
//
//  Created by HN on 2020/3/20.
//  Copyright © 2020 HN. All rights reserved.
//

#import "ListCell.h"

@interface ListCell ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self makeGesture];
}

- (void)dealloc
{
    [self removeGestureRecognizer:self.longPressGesture];
}

- (void)makeGesture
{
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    self.longPressGesture.delegate = self;
    [self.textView addGestureRecognizer:self.longPressGesture];
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    return NO;
//}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)onLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(listCell:textView:)]) {
            [self.delegate listCell:self textView:self.textView];
            
            self.textView.selectedRange = NSMakeRange(0, self.textView.text.length);
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*) otherGestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && [NSStringFromClass([otherGestureRecognizer class])isEqualToString:@"UITextTapRecognizer"])
    {
        return NO;
    }
    return YES;
}

@end

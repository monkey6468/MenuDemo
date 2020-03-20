//
//  ListCell.m
//  MenuDemo
//
//  Created by HN on 2020/3/20.
//  Copyright © 2020 HN. All rights reserved.
//

#import "ListCell.h"

@interface ListCell ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

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
    [self.textView addGestureRecognizer:self.longPressGesture];
}

- (void)onLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(listCell:textView:)]) {
            [self.delegate listCell:self textView:self.textView];
            
            self.textView.selectedRange = NSMakeRange(0, self.textView.text.length);
        }
    }
}

@end

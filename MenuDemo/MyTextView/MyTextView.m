//
//  MyTextView.m
//  MenuDemo
//
//  Created by HN on 2020/1/16.
//  Copyright © 2020 HN. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView
//- (UIResponder *)nextResponder {
//    if (_inputNextResponder != nil)
//    {
//        NSLog(@"%s-1",__func__);
//        return _inputNextResponder;
//    }
//    else {
//        NSLog(@"%s-2-- %ld",__func__,[UIMenuController sharedMenuController].menuItems.count);
////        [UIMenuController sharedMenuController].menuItems = nil;
//        return [super nextResponder];
//    }
//}
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    if (pasteboard.string.length) {
//        UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"需要黏贴" action:@selector(selfMenu:)];
//        UIMenuController *menuController = [UIMenuController sharedMenuController];
//        [
//         menuController
//         setMenuItems:[NSArray arrayWithObject:menuItem]];
//        [menuController setMenuVisible:NO];
//    }
//}
//- (instancetype)initWithFrame:(CGRect)frame{
//
//    self = [super initWithFrame:frame];
//    if (self) {
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        if (pasteboard.string.length) {
//            UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"需要黏贴" action:@selector(selfMenu:)];
//            UIMenuController *menuController = [UIMenuController sharedMenuController];
//            [
//             menuController
//             setMenuItems:[NSArray arrayWithObject:menuItem]];
//            [menuController setMenuVisible:NO];
//        }
//    }
//    return self;
//}

//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
////    [UIMenuController sharedMenuController].menuItems = nil;
////    return NO;
////    if (_inputNextResponder != nil) {
////        NSLog(@"%s-1",__func__);
////        return NO;
////    }
//    NSLog(@"%s-2",__func__);
//    return [super canPerformAction:action withSender:sender];
////    if (action == @selector(selfMenu:)) {
////        return YES;
////    }
////    return NO;
//}

////自定义的事件
//- (void)selfMenu:(id)sender{
//    
//    
//}

@end

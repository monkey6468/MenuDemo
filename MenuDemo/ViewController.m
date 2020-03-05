//
//  ViewController.m
//  MenuDemo
//
//  Created by HN on 2020/1/15.
//  Copyright © 2020 HN. All rights reserved.
//

#import "ViewController.h"
#import "MyTextView.h"
#import "MyLabel.h"
#import "MenuDemo-Swift.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet MyTextView *textViewInput;
@property (weak, nonatomic) IBOutlet MyLabel *label2;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) BOOL bMenuShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.tintColor = UIColor.redColor;
//    self.textView.tintColor = UIColor.redColor;

    //设置输入视图
    [self addNotify];
}

- (void)addNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidHideMenu:) name:UIMenuControllerDidHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillShowMenu:) name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillHideMenu:) name:UIMenuControllerWillHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MenuFrameDidChange:) name:UIMenuControllerMenuFrameDidChangeNotification object:nil];
}
- (void)DidHideMenu:(NSNotification *)notify
{
    [self resignFirstResponder];
//    if (self.bMenuShow == YES && [UIMenuController sharedMenuController].menuItems.count) {
//        [UIMenuController sharedMenuController].menuItems = nil;
//    }
    NSLog(@"%s",__func__);
}
- (void)WillShowMenu:(NSNotification *)notify
{
//    self.bMenuShow = YES;
//    if (self.bMenuShow == YES && [UIMenuController sharedMenuController].menuItems.count) {
//        [UIMenuController sharedMenuController].menuItems = nil;
//    }
    NSLog(@"%s",__func__);
}
- (void)WillHideMenu:(NSNotification *)notify
{
//    self.bMenuShow = NO;
//    [UIMenuController sharedMenuController].menuItems = nil;
    NSLog(@"%s",__func__);
}
- (void)MenuFrameDidChange:(NSNotification *)notify
{
    NSLog(@"%s",__func__);
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"%s",__func__);
    return YES;
}
//- (BOOL)becomeFirstResponder
//{
//    NSLog(@"%s",__func__);
//    return YES;
//}
//- (UIResponder *)nextResponder
//{
//    NSLog(@"%s",__func__);
////    if (self.bMenuShow == YES && [UIMenuController sharedMenuController].menuItems.count) {
////        [UIMenuController sharedMenuController].menuItems = nil;
////    }
//    return [super nextResponder];
//}
- (IBAction)longPress1:(UILongPressGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]
        && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self onLongPressInView:self.textView];
       
        //要成为第一响应者,否则无效
        [self.textView becomeFirstResponder];

//        self.textView.selectedRange = NSMakeRange(0, self.textView.text.length);
        [self.textView setSelectedTextRange:[self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:self.textView.endOfDocument]];
    }
}
- (IBAction)longPress2:(UILongPressGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]
        && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        [self onLongPressInView:self.label2];
//        [self.label2 setSelectedTextRange:[self.label2 textRangeFromPosition:self.label2.beginningOfDocument toPosition:self.label2.endOfDocument]];
    }
}
//- (void)addSWMenuController:(UIView *)view
//{
//    SWMenuController *menu = [[SWMenuController alloc]init];
//    menu.delegate = self;
//    menu.menuItems = @[@"撤回2",@"复制2"];
//    [menu setTargetRect:CGRectMake(CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds)+5,
//                                   CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)) in:view];
//    [menu setMenuVisible:YES animated:YES];
//}
//- (void)menuController:(SWMenuController *)menu didSelected:(NSInteger)index
//{
//    NSLog(@"didSelected: %ld",index);
//}
- (void)onLongPressInView:(UIView *)view
{
//    if (self.textViewInput.isFirstResponder) {
//        self.textViewInput.inputNextResponder = self;
//    } else {
//        [self becomeFirstResponder];
//    }
//    [UIView animateWithDuration:0.001 delay:0 options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//        [self becomeFirstResponder];
//    } completion:^(BOOL finished) {
//        [self.textViewInput becomeFirstResponder];
//    }];
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//    [self.textViewInput resignFirstResponder];
//    [self becomeFirstResponder];
//    [self.textView becomeFirstResponder];
    
//    [view resignFirstResponder];

    NSArray *items = [self menusItems];
    if ([items count]) {
        UIMenuController *controller = [UIMenuController sharedMenuController];
        controller.menuItems = items;
        [controller setTargetRect:CGRectMake(CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds)+5,
                                             CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))
                           inView:view];
        [controller setMenuVisible:YES animated:YES];
    }
//    self.textViewInput.editable = NO;
//    [self.textViewInput becomeFirstResponder];

}

#pragma mark - 菜单
- (NSArray *)menusItems
{
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回2"
                                                action:@selector(copyText:)]];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制2"
                                                action:@selector(copyText2:)]];
//    [items addObject:[[UIMenuItem alloc] initWithTitle:@"转发"
//                                                action:@selector(copyText:)]];
//    [items addObject:[[UIMenuItem alloc] initWithTitle:@"收藏"
//                                                action:@selector(copyText:)]];
//    [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除"
//                                                action:@selector(copyText:)]];
    return items;
    
}
- (void)copyText:(id)sender
{
    NSLog(@"%s-撤回",__func__);
}
- (void)copyText2:(id)sender
{
    NSLog(@"%s-复制",__func__);
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (self.textViewInput.isFirstResponder == NO)
//    {
//        return [super canPerformAction:action withSender:sender];
//           NSArray *items = [[UIMenuController sharedMenuController] menuItems];
//           for (UIMenuItem *item in items) {
//               if (action == [item action]){
//                   return YES;
//               }
//           }
//           return NO;
//    }else
//    {
//        return NO;
//    }
////    return [super canPerformAction:action withSender:sender];
////    NSArray *items = [[UIMenuController sharedMenuController] menuItems];
////    for (UIMenuItem *item in items) {
////        if (action == [item action]){
////            return YES;
////        }
////    }
////    return NO;
//}

- (void)menuDidHide:(NSNotification *)notification
{
    [UIMenuController sharedMenuController].menuItems = nil;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    CGPoint point1 = [self.textView.layer convertPoint:point fromLayer:self.view.layer];
//    CGPoint point2 = [self.label2.layer convertPoint:point fromLayer:self.view.layer];
//
//    if ([self.textView.layer containsPoint:point1]
//        ||[self.label2.layer containsPoint:point2]) {
//        
//    } else {
//        [self.view endEditing:YES];
//    }
}
@end

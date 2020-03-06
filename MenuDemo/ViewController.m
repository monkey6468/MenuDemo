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
#import "KLPopMenu.h"

@interface ViewController ()<UITextViewDelegate, KLPopMenuDelegate>
@property (weak, nonatomic) IBOutlet MyTextView *textViewInput;
@property (strong, nonatomic) KLPopMenu *popMenu;
@property (weak, nonatomic) IBOutlet MyLabel *label2;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) BOOL bMenuShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _popMenu = [KLPopMenu new];
    _popMenu.delegate = self;

    self.textView.tintColor = UIColor.redColor;
//    self.textView.tintColor = UIColor.redColor;
    [self.textViewInput becomeFirstResponder];
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
    [_popMenu hid];
    NSLog(@"%s",__func__);
}
- (void)WillHideMenu:(NSNotification *)notify
{
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

- (IBAction)longPress1:(UILongPressGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]
        && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self onLongPressInView:self.textView];
       
        //要成为第一响应者,否则无效
//        [self.textView resignFirstResponder];
//        [self.textViewInput nextResponder];
////        self.textView.selectedRange = NSMakeRange(0, self.textView.text.length);
//        [self.textView setSelectedTextRange:[self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:self.textView.endOfDocument]];
    }
}
- (IBAction)longPress2:(UILongPressGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]
        && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        NSArray *itemList = @[@"撤回", @"复制", @"转发", @"收藏", @"删除"];
        [_popMenu showItemList:itemList withTargetView:self.label2];

//        [self onLongPressInView:self.label2];
//        [self.label2 setSelectedTextRange:[self.label2 textRangeFromPosition:self.label2.beginningOfDocument toPosition:self.label2.endOfDocument]];
    }
}

- (void)onLongPressInView:(UIView *)view
{
    NSArray *items = [self menusItems];
    if ([items count]) {
        UIMenuController *controller = [UIMenuController sharedMenuController];
        controller.menuItems = items;
        [controller setTargetRect:CGRectMake(CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds)+5,
                                             CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))
                           inView:view];
        [controller setMenuVisible:YES animated:YES];
    }

}

#pragma mark - 菜单
- (NSArray *)menusItems
{
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回"
                                                action:@selector(copyText:)]];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制"
                                                action:@selector(copyText:)]];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"转发"
                                                action:@selector(copyText:)]];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"收藏"
                                                action:@selector(copyText:)]];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除"
                                                action:@selector(copyText:)]];
    return items;
    
}

- (void)copyText:(id)sender
{
    NSLog(@"%s-复制",__func__);
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)menuDidHide:(NSNotification *)notification
{
    [UIMenuController sharedMenuController].menuItems = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_popMenu hid];
}

#pragma mark - KLPopMenuDelegate
- (void)popMenuClickedWithTitle:(NSString *)title {
    NSLog(@"--%@", title);
}

@end

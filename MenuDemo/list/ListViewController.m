//
//  ListViewController.m
//  MenuDemo
//
//  Created by HN on 2020/3/20.
//  Copyright © 2020 HN. All rights reserved.
//

#import "ListViewController.h"

#import "ListCell.h"
#import "MyTextView.h"
#import "MyButton.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, ListCellDelegate, UIGestureRecognizerDelegate, MyTextViewDelegate, MyButtonDelegate>
{
    BOOL showMenu;
    NSIndexPath *path;
}
@property (weak, nonatomic) IBOutlet MyTextView *inputTopTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet MyButton *testButton;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ListViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputTopTextView.tintColor = UIColor.redColor;
    self.inputTopTextView.myDelegate = self;
    self.testButton.myDelegate = self;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class])
                                               bundle:nil]
         forCellReuseIdentifier:NSStringFromClass(ListCell.class)];
}

#pragma mark - other
- (IBAction)onTapTopTextView:(id)sender {
    self.inputTopTextView.selectedRange = NSMakeRange(0, self.inputTopTextView.text.length);
    [self onLongPressInView:self.inputTopTextView];
}

- (IBAction)onTapTestButton:(id)sender {
    [self onLongPressInView:self.testButton];
}

- (void)copyText:(id)sender
{
    NSLog(@"%s-复制",__func__);
}
- (IBAction)onActionTestButton:(UIButton *)sender {
//    self.testButton.selectedRange = NSMakeRange(0, self.testButton.length);
    [self onLongPressInView:self.testButton];
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(copyText:))
//    {
//        return YES;
//    }
//
//    return NO;
//}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    for(UIGestureRecognizer *recognizer in self.inputTopTextView.gestureRecognizers) {
//        NSLog(@"inputTopTextView: %@",[recognizer class]);
//    }
//    return NO;
//}·
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

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

- (void)onLongPressInView:(UIView *)view
{
    [view becomeFirstResponder];
    NSArray *items = [self menusItems];
    if ([items count]) {
        [UIMenuController sharedMenuController].menuItems = nil;
        UIMenuController *controller = [UIMenuController sharedMenuController];
        controller.menuItems = items;
        [controller setTargetRect:CGRectMake(CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds)+5,
                                             CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))
                           inView:view];
        [controller setMenuVisible:YES animated:YES];
    }

}

- (void)menuDidHide:(NSNotification *)notification
{
    [UIMenuController sharedMenuController].menuItems = nil;
}

#pragma mark - MyTextViewDelegate
- (BOOL)myTextViewHasText:(MyTextView *)view
{
    return self.inputTextField.hasText;
}

#pragma mark - MyButtonDelegate
- (BOOL)myButtonHasText:(MyButton *)view
{
    return self.inputTextField.hasText;
}

#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*) otherGestureRecognizer
//{
//    NSLog(@"gestureRecognizer--%@",[gestureRecognizer class]);
//    NSLog(@"otherGestureRecognizer--%@",[otherGestureRecognizer class]);
//
//    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && [NSStringFromClass([otherGestureRecognizer class])isEqualToString:@"UITextTapRecognizer"])
//    {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - ListCellDelegate
- (void)listCell:(ListCell *)cell textView:(nonnull UITextView *)textView
{
    NSLog(@"message: %@", textView.text);
}

#pragma mark - UITableViewDelegate, UITableViewDataSourceher
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ListCell.class)];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!showMenu) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    showMenu = NO;
}

#pragma mark - 三个系统代理必须全部实现！

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    showMenu = YES;
    path = indexPath;
    
    //cell中需要重写canBecomeFirstResponder
    ListCell * cell = (ListCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    //需要成为第一响应者
    [cell.textView becomeFirstResponder];
    
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    //这里的frame影响箭头的位置
    CGRect rect = cell.textView.frame;
    rect.size.width= 200;
    [menu setTargetRect:rect inView:tableView];
    
    //添加你要自定义的MenuItem
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                  action:@selector(copyText:)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                   action:@selector(copyText:)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"编辑"
                                                   action:@selector(copyText:)];
    UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"转发"
                                                   action:@selector(copyText:)];
    UIMenuItem *item5 = [[UIMenuItem alloc] initWithTitle:@"分享分享"
                                                   action:@selector(copyText:)];
    menu.menuItems = [NSArray arrayWithObjects:item,item2,item3,item4,item5,nil];
    
    [menu setMenuVisible:YES animated:YES];
    
    //return YES or NO 都可以
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {

    //屏蔽掉系统的copy:等其它函数
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    //这里只会调用系统的SEL
    if (action == @selector(copy:)) {
        
       // [UIPasteboard generalPasteboard].string = [data objectAtIndex:indexPath.row];
    }
}


#pragma mark - getter or setter
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_dataArray addObject:@(i)];
        }
    }
    return _dataArray;
}
@end

//
//  ListViewController.m
//  MenuDemo
//
//  Created by HN on 2020/3/20.
//  Copyright © 2020 HN. All rights reserved.
//

#import "ListViewController.h"

#import "ListCell.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, ListCellDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputTopTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture2;

@end

@implementation ListViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputTopTextView.tintColor = UIColor.redColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class])
                                               bundle:nil]
         forCellReuseIdentifier:NSStringFromClass(ListCell.class)];
    
    [self makeGesture];
}

- (void)dealloc
{
    [self.inputTopTextView removeGestureRecognizer:self.longPressGesture];
}

#pragma mark - other
- (void)makeGesture
{
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    self.longPressGesture.delegate = self;
    [self.inputTopTextView addGestureRecognizer:self.longPressGesture];
}

- (void)onLongPress:(UILongPressGestureRecognizer *)sender {
//    for(UIGestureRecognizer *recognizer in self.inputTopTextView.gestureRecognizers) {
//        NSLog(@"inputTopTextView: %@",[recognizer class]);
//    }
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"%s",__func__);
        self.inputTopTextView.selectedRange = NSMakeRange(0, self.inputTopTextView.text.length);
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
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

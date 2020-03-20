//
//  ListViewController.m
//  MenuDemo
//
//  Created by HN on 2020/3/20.
//  Copyright © 2020 HN. All rights reserved.
//

#import "ListViewController.h"

#import "ListCell.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, ListCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class])
                                               bundle:nil]
         forCellReuseIdentifier:NSStringFromClass(ListCell.class)];
}

#pragma mark - ListCellDelegate
- (void)listCell:(ListCell *)cell textView:(nonnull UITextView *)textView
{
//     textView.selectedRange = NSMakeRange(0, textView.text.length);
    
//    [textView setSelectedTextRange:[textView textRangeFromPosition:textView.beginningOfDocument toPosition:textView.endOfDocument]];
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
        for (int i = 0; i < 10; i++) {
            [_dataArray addObject:@(i)];
        }
    }
    return _dataArray;
}
@end

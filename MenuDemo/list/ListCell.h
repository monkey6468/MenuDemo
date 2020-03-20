//
//  ListCell.h
//  MenuDemo
//
//  Created by HN on 2020/3/20.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ListCell;
@protocol ListCellDelegate <NSObject>

- (void)listCell:(ListCell *)cell
         textView:(UITextView *)textView;

@end

@interface ListCell : UITableViewCell

@property (nonatomic, weak) id<ListCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

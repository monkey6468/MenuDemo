//
//  MyTextView.h
//  MenuDemo
//
//  Created by HN on 2020/1/16.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTextView : UITextView
@property (nonatomic, weak) UIResponder *inputNextResponder;
@property (nonatomic, assign) BOOL bMenuShow;

@end

NS_ASSUME_NONNULL_END

//
//  MyTextView.h
//  MenuDemo
//
//  Created by HN on 2020/4/17.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyTextView;
@protocol MyTextViewDelegate <NSObject>

- (BOOL)myTextViewHasText:(MyTextView *)view;

@end

@interface MyTextView : UITextView <UIKeyInput>

@property (nonatomic, assign) id<MyTextViewDelegate> myDelegate;
//@property (nonatomic, assign) BOOL hasText;
@end

NS_ASSUME_NONNULL_END

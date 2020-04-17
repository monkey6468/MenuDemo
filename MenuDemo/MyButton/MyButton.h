//
//  MyButton.h
//  MenuDemo
//
//  Created by HN on 2020/4/17.
//  Copyright © 2020 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyButton;
@protocol MyButtonDelegate <NSObject>

- (BOOL)myButtonHasText:(MyButton *)view;

@end
@interface MyButton : UIButton <UIKeyInput>

@property (nonatomic, assign) id<MyButtonDelegate> myDelegate;

@end

NS_ASSUME_NONNULL_END

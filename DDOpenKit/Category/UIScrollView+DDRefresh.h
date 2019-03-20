//
//  UIScrollView+DDRefresh.h
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/12/26.
//  Copyright © 2018 DD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (DDRefresh)

- (void)setRefresh;

- (void)setLoadMore;
/**当刷新的时候回调的方法*/
- (void)setOnRefreshOrLoadMoreCallBackWithBlock:(void(^)(NSInteger currentPage,NSInteger pageSize,void(^refreshFinish)(BOOL isRefreshSuccess,BOOL noMoreData)))block;

@property (nonatomic,assign)NSInteger currentPage;
/**每页查询 默认是20条*/
@property (nonatomic,assign)NSInteger pageSize;

- (void)startRefresh;

- (void)startLoadMore;

- (void)endRefresh;
/**是否正在刷新*/
@property (nonatomic,assign)BOOL isRefreshIng;

@end

NS_ASSUME_NONNULL_END

//
//  UIScrollView+DDRefresh.m
//  YunTaiXin
//
//  Created by 戴俊毅 on 2018/12/26.
//  Copyright © 2018 DD. All rights reserved.
//

#import "UIScrollView+DDRefresh.h"
#import <objc/runtime.h>

static char currentPageKey;
static char setOnRefreshOrLoadMoreCallBackWithBlockKey;
static char pageSizeKey;
static char isRefreshIngKey;

@implementation UIScrollView (DDRefresh)

- (void)setRefresh{
    if (self.mj_header) {
        return;
    }
    __weak typeof(self)weakSelf = self;
    self.currentPage = 1;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (strongSelf.isRefreshIng) {
            return;
        }
        strongSelf.isRefreshIng = true;
        strongSelf.currentPage = 1;
        [strongSelf.mj_footer resetNoMoreData];
        void (^block)(NSInteger currentPage,NSInteger pageSize,void(^refreshFinish)(BOOL isRefreshSuccess,BOOL noMoreData)) = objc_getAssociatedObject(strongSelf, &setOnRefreshOrLoadMoreCallBackWithBlockKey);
        if (block) {
            block(strongSelf.currentPage,strongSelf.pageSize,^(BOOL isRefreshSuccess,BOOL noMoreData){
                __strong typeof(weakSelf)strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (isRefreshSuccess) {
                    strongSelf.currentPage++;
                }
                if (noMoreData) {
                    [strongSelf.mj_footer endRefreshingWithNoMoreData];
                }
                [strongSelf endRefresh];
            });
        }
    }];
}

- (void)setLoadMore{
    if (self.mj_footer) {
        return;
    }
    __weak typeof(self)weakSelf = self;
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (strongSelf.isRefreshIng) {
            return;
        }
        strongSelf.isRefreshIng = true;
        void (^block)(NSInteger currentPage,NSInteger pageSize,void(^refreshFinish)(BOOL isRefreshSuccess,BOOL noMoreData)) = objc_getAssociatedObject(strongSelf, &setOnRefreshOrLoadMoreCallBackWithBlockKey);
        if (block) {
            block(strongSelf.currentPage,strongSelf.pageSize,^(BOOL isRefreshSuccess,BOOL noMoreData){
                __strong typeof(weakSelf)strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                if (isRefreshSuccess) {
                    strongSelf.currentPage++;
                }
                if (noMoreData) {
                    [strongSelf.mj_footer endRefreshingWithNoMoreData];
                }
                [strongSelf endRefresh];
            });
        }
    }];
}

- (void)endRefresh{
    self.isRefreshIng = false;
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)startRefresh{
    if (self.mj_header == nil) {
        [self setRefresh];
    }
    [self.mj_header beginRefreshing];
}

-(void)startLoadMore{
    if (self.mj_footer == nil) {
        [self setLoadMore];
    }
    [self.mj_footer beginRefreshing];
}

- (void)setOnRefreshOrLoadMoreCallBackWithBlock:(void (^)(NSInteger currentPage,NSInteger pageSize,void(^refreshFinish)(BOOL isRefreshSuccess,BOOL noMoreData)))block{
    objc_setAssociatedObject(self, &setOnRefreshOrLoadMoreCallBackWithBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setCurrentPage:(NSInteger)currentPage{
    objc_setAssociatedObject(self, &currentPageKey, [NSString stringWithFormat:@"%ld",currentPage], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)currentPage{
    NSString *currentPage = objc_getAssociatedObject(self, &currentPageKey);
    return currentPage.integerValue;
}

- (NSInteger)pageSize{
    NSString *pageSize = objc_getAssociatedObject(self, &pageSizeKey);
    NSInteger size = pageSize.integerValue;
    if (size == 0) {
        return 20;
    }else{
        return size;
    }
}

- (void)setPageSize:(NSInteger)pageSize{
    objc_setAssociatedObject(self, &currentPageKey, [NSString stringWithFormat:@"%ld",pageSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsRefreshIng:(BOOL)isRefreshIng{
    objc_setAssociatedObject(self, &isRefreshIngKey, [[NSNumber alloc] initWithBool:isRefreshIng], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isRefreshIng{
    NSNumber *refreshing = objc_getAssociatedObject(self, &isRefreshIngKey);
    return refreshing.boolValue;
}

@end

//
//  HJTableViewCell.m
//  HJSnapshotDemo
//
//  Created by WHJ on 2018/1/12.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "HJTableViewCell.h"


@interface HJTableViewCell ()


@end

@implementation HJTableViewCell



- (void)layoutSubviews{
    
    self.imageView.frame = self.bounds;
    self.imageView.contentMode = UIViewContentModeCenter;
}



@end

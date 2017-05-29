//
//  BasicCell.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/25/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@implementation BasicCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textColor = Color_Text;
    }
    return self;
}

- (void)cleanUpSubviews {
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    [super cleanUpSubviews];
}

@end

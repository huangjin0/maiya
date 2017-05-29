//
//  StringHelper.h
//  DrivingNeighborSchool
//
//  Created by Kiwi Wan on 14-5-15.
//  Copyright (c) 2014年 Kiwi Private. All rights reserved.
//

#ifndef Memories_StringHelper_h
#define Memories_StringHelper_h


#define String(__key) NSLocalizedString(__key, nil)


//#define ArtFont(_font) [UIFont fontWithName:@"Lato-Regular" size:_font]
//#define TextFont(_font) [UIFont fontWithName:@"Lato-Regular" size:_font]


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define TextSize(_text, _font) [_text length] > 0 ? [_text sizeWithAttributes:@{NSFontAttributeName:_font}] : CGSizeZero;
#else
#define TextSize(_text, _font) [_text length] > 0 ? [_text sizeWithFont:_font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define TextSize_MutiLine(_text, _font, _maxSize) [_text length] > 0 ? [_text boundingRectWithSize:_maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:_font} context:nil].size : CGSizeZero;
#else
#define TextSize_MutiLine(_text, _font, _maxSize) [_text length] > 0 ? [_text sizeWithFont:_font constrainedToSize:_maxSize lineBreakMode:NSLineBreakByWordWrapping] : CGSizeZero;
#endif


#endif

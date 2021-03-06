//
//  PopupView.h
//  HWMonitor
//
//  Created by kozlek on 23.02.13.
//  Based on code by Vadim Shpanovski <https://github.com/shpakovski/Popup>
//  Popup is licensed under the BSD license.
//  Copyright (c) 2013 Vadim Shpanovski, Natan Zalkin. All rights reserved.
//

#define LINE_THICKNESS      1.0f
#define ARROW_WIDTH         22.0f
#define ARROW_HEIGHT        11.0f
#define ARROW_OFFSET        3.0f
#define CORNER_RADIUS       5.0f

#import "ColorTheme.h"

@interface PopupView : NSView
{
    CGFloat         _arrowPosition;
    ColorTheme      *_colorTheme;
    NSRect          _popupBounds;

    NSImage         *_cachedImage;
}

@property (nonatomic, setter = setArrowPosition:) CGFloat arrowPosition;
@property (nonatomic, setter = setColorTheme:) ColorTheme *colorTheme;

@end

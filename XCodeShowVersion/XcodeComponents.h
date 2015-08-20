//
//  XcodeComponents.h
//  XCodeShowVersion
//
//  Created by MuronakaHiroaki on 2015/08/19.
//  Copyright (c) 2015年 hmu. All rights reserved.
//

#ifndef XCodeShowVersion_XcodeComponents_h
#define XCodeShowVersion_XcodeComponents_h

@interface IDEAboutWindowController : NSWindowController

+ (id)sharedAboutWindowController;
- (id)_versionString;

@end


#endif

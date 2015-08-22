//
//  XCodeShowVersion.m
//  XCodeShowVersion
//
//  Created by MuronakaHiroaki on 2015/08/19.
//  Copyright (c) 2015年 hmu. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "XCodeShowVersion.h"
#import "XcodeComponents.h"

@implementation XCodeShowVersion

static XCodeShowVersion* _sharedInstance = nil;
#define kVersionUnknown @"version unknown"

+(void)pluginDidLoad:(NSBundle*)plugin {
    [self sharedInstance];
}

#pragma mark class methods.

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark instance methods.

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

-(void)applicationDidFinishLaunching:(NSNotification*)noti {
    [self initMenu];
}

-(NSString*)getXcodeVersion {
    NSString* result;
    IDEAboutWindowController* vc = [IDEAboutWindowController sharedAboutWindowController];
    result = [vc _versionString] ? [vc _versionString] : kVersionUnknown;
    return result;
}

-(void)initMenu {
    [self addVersionMenu];
}

-(void)addVersionMenu {
    NSMenu* mainMenu = [NSApp mainMenu];
    
    NSMenu *versionMenu = [[NSMenu alloc] initWithTitle:[self getXcodeVersion]];
    NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:[self getXcodeVersion] action:NULL keyEquivalent:@""];
    [newMenuItem setSubmenu:versionMenu];
    [mainMenu addItem:newMenuItem];
}

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
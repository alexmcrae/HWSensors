//
//  UpdatesController.m
//  HWMonitor
//
//  Created by kozlek on 20.03.13.
//  Copyright (c) 2013 kozlek. All rights reserved.
//

#import "UpdatesController.h"

#import "Localizer.h"
#import "HWMonitorDefinitions.h"

#define DOWNLOADS_URL @"https://bitbucket.org/kozlek/hwsensors/downloads"

@interface UpdatesController ()

@end

@implementation UpdatesController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    
    if (self) {
        [self performSelector:@selector(localizeWindow) withObject:nil afterDelay:0.0];
        [self performSelector:@selector(checkForUpdates) withObject:nil afterDelay:60.0];
    }
    
    return self;
}

- (void)localizeWindow
{
    [Localizer localizeView:self.window];
}

- (void)checkForUpdates
{
    NSURL *url = [NSURL URLWithString:@"https://github.com/kozlek/HWSensors/raw/master/Shared/version.plist"];
    NSMutableDictionary *list = [[NSMutableDictionary alloc] initWithContentsOfURL:url];
    
    if (list) {
        _currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _remoteVersion = [list objectForKey:@"AppVersion"];
        _skippedVersion = [[[NSUserDefaultsController sharedUserDefaultsController] defaults] objectForKey:kHWMonitorSkippedAppVersion];
        
        [_messageTextField setStringValue:[NSString stringWithFormat:[_messageTextField stringValue], _remoteVersion, _currentVersion]];
        
        if (_currentVersion && _remoteVersion && [_remoteVersion isGreaterThan:_currentVersion] && (!_skippedVersion || [_skippedVersion isLessThan:_remoteVersion])) {
            [NSApp activateIgnoringOtherApps:YES];
            [self.window makeKeyAndOrderFront:nil];
        }
    }

    // continue check for updates every hour???
    //[self performSelector:@selector(checkForUpdates) withObject:nil afterDelay:60.0 * 60];
}

- (IBAction)openDownloadsPage:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:DOWNLOADS_URL]];
    [self.window close];
}

-(void)cancelUpdate:(id)sender
{
    [self.window close];
}

- (IBAction)skipVersion:(id)sender
{
    [self.window close];
    
    [[[NSUserDefaultsController sharedUserDefaultsController] defaults] setObject:_remoteVersion forKey:kHWMonitorSkippedAppVersion];
}

@end

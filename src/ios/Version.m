#import "Version.h"
#import <Cordova/CDVPluginResult.h>

@implementation Version

- (void)getInfos:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    // Getting the app informations
    NSString* versionCode = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString* versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (versionNumber == nil) {
      NSLog(@"CFBundleShortVersionString was nil, attempting CFBundleVersion");
      versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
      if (versionNumber == nil) {
        NSLog(@"CFBundleVersion was also nil, giving up");
        // not calling error callback here to maintain backward compatibility
      }
    }
    NSString* packageName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString* appName = [[[NSBundle mainBundle]infoDictionary]objectForKey :@"CFBundleDisplayName"];
    // Build result object
    NSMutableDictionary* returnInfo = [NSMutableDictionary dictionaryWithCapacity:4];
    [returnInfo setValue:appName forKey:@"appName"];
    [returnInfo setValue:packageName forKey:@"packageName"];
    [returnInfo setValue:versionNumber forKey:@"versionNumber"];
    [returnInfo setValue:versionCode forKey:@"versionCode"];
    // Give it back to the Javascript
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnInfo];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

@end

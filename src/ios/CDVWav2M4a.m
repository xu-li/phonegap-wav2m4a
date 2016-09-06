//
//  CDVWav2M4a.m
//
//  Created by xu.li on 12/19/13.
//
//

#import "CDVWav2M4a.h"


@implementation CDVWav2M4a

- (void)convert:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* src = [command.arguments objectAtIndex:0];
    NSString* target = [command.arguments objectAtIndex:1];
    
    // check target file
    if (!target)
    {
        target = [[src stringByDeletingPathExtension] stringByAppendingPathExtension:@"m4a"];
    }
    
    // check if source file exists
    if ([[NSFileManager defaultManager] fileExistsAtPath:target]) {
        NSError* err;
        [[NSFileManager defaultManager] removeItemAtPath:target error:&err];
        if(err){
            NSLog(@"Strange error code: %ld", (long)err.code);
            NSLog(@"Strange descriprion code: %@", [err localizedDescription]);
        }
    }


    // check if source file exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:src])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Source file doesn't exist."];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return ;
    }
    else
    {
        NSURL* srcUrl = [NSURL fileURLWithPath:src];
        AVURLAsset* audioAsset = [[AVURLAsset alloc] initWithURL:srcUrl options:nil];
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:audioAsset presetName:AVAssetExportPresetAppleM4A];
        NSURL *url =  [NSURL fileURLWithPath:target];
        session.outputURL = url;

        session.outputFileType = AVFileTypeAppleM4A;
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            CDVPluginResult* pluginResult = nil;
            
            if (session.status == AVAssetExportSessionStatusCompleted)
            {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            }
            else
            {
                NSString *msg = [session.error localizedDescription];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msg];
            }
            
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
}


@end

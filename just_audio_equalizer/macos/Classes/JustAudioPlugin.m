#import "JustAudioEqualizerPlugin.h"
#if __has_include(<just_audio_equalizer/just_audio_equalizer-Swift.h>)
#import <just_audio_equalizer/just_audio_equalizer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "just_audio_equalizer-Swift.h"
#endif

#import <AVFoundation/AVFoundation.h>

@implementation JustAudioEqualizerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJustAudioPlugin registerWithRegistrar:registrar];
}
@end

import 'dart:async';

import 'package:flutter/services.dart';

import 'just_audio_platform_interface.dart';

/// An implementation of [JustAudioPlatform] that uses method channels.
class MethodChannelJustAudio extends JustAudioPlatform {
  static const _mainChannel =
      MethodChannel('com.anket.just_audio_equalizer.methods');

  MethodChannelJustAudio() {
    errorsStream.listen((exception) => throw exception);
  }

  Stream<PlatformException> get errorsStream =>
      const EventChannel('com.anket.just_audio_equalizer.errors')
          .receiveBroadcastStream()
          .cast<Map<dynamic, dynamic>>()
          .map((map) => PlatformException(
                code: map['code'] as String,
                message: map['message'] as String?,
                details: map['details'] as String?,
              ));

  @override
  Future<AudioPlayerPlatform> init(InitRequest request) async {
    await _mainChannel.invokeMethod<void>('init', request.toMap());
    return MethodChannelAudioPlayer(request.id);
  }

  @override
  Future<DisposePlayerResponse> disposePlayer(
      DisposePlayerRequest request) async {
    return DisposePlayerResponse.fromMap(
        (await _mainChannel.invokeMethod<Map<dynamic, dynamic>>(
            'disposePlayer', request.toMap()))!);
  }

  @override
  Future<DisposeAllPlayersResponse> disposeAllPlayers(
      DisposeAllPlayersRequest request) async {
    return DisposeAllPlayersResponse.fromMap(
        (await _mainChannel.invokeMethod<Map<dynamic, dynamic>>(
            'disposeAllPlayers', request.toMap()))!);
  }
}

/// An implementation of [AudioPlayerPlatform] that uses method channels.
class MethodChannelAudioPlayer extends AudioPlayerPlatform {
  final MethodChannel _channel;

  MethodChannelAudioPlayer(String id)
      : _channel = MethodChannel('com.anket.just_audio_equalizer.methods.$id'),
        super(id);

  @override
  Stream<PlaybackEventMessage> get playbackEventMessageStream =>
      EventChannel('com.anket.just_audio_equalizer.events.$id')
          .receiveBroadcastStream()
          .cast<Map<dynamic, dynamic>>()
          .map((map) => PlaybackEventMessage.fromMap(map));

  @override
  Stream<PlayerDataMessage> get playerDataMessageStream =>
      EventChannel('com.anket.just_audio_equalizer.data.$id')
          .receiveBroadcastStream()
          .map((dynamic map) =>
              PlayerDataMessage.fromMap(map as Map<dynamic, dynamic>));

  @override
  Future<LoadResponse> load(LoadRequest request) async {
    return LoadResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('load', request.toMap()))!);
  }

  @override
  Future<PlayResponse> play(PlayRequest request) async {
    return PlayResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('play', request.toMap()))!);
  }

  @override
  Future<PauseResponse> pause(PauseRequest request) async {
    return PauseResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('pause', request.toMap()))!);
  }

  @override
  Future<SetVolumeResponse> setVolume(SetVolumeRequest request) async {
    return SetVolumeResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('setVolume', request.toMap()))!);
  }

  @override
  Future<SetSpeedResponse> setSpeed(SetSpeedRequest request) async {
    return SetSpeedResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('setSpeed', request.toMap()))!);
  }

  @override
  Future<SetPitchResponse> setPitch(SetPitchRequest request) async {
    return SetPitchResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('setPitch', request.toMap()))!);
  }

  @override
  Future<SetSkipSilenceResponse> setSkipSilence(
      SetSkipSilenceRequest request) async {
    return SetSkipSilenceResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setSkipSilence', request.toMap()))!);
  }

  @override
  Future<SetLoopModeResponse> setLoopMode(SetLoopModeRequest request) async {
    return SetLoopModeResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('setLoopMode', request.toMap()))!);
  }

  @override
  Future<SetShuffleModeResponse> setShuffleMode(
      SetShuffleModeRequest request) async {
    return SetShuffleModeResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setShuffleMode', request.toMap()))!);
  }

  @override
  Future<SetShuffleOrderResponse> setShuffleOrder(
      SetShuffleOrderRequest request) async {
    return SetShuffleOrderResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setShuffleOrder', request.toMap()))!);
  }

  @override
  Future<SetAutomaticallyWaitsToMinimizeStallingResponse>
      setAutomaticallyWaitsToMinimizeStalling(
          SetAutomaticallyWaitsToMinimizeStallingRequest request) async {
    return SetAutomaticallyWaitsToMinimizeStallingResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setAutomaticallyWaitsToMinimizeStalling', request.toMap()))!);
  }

  @override
  Future<SetCanUseNetworkResourcesForLiveStreamingWhilePausedResponse>
      setCanUseNetworkResourcesForLiveStreamingWhilePaused(
          SetCanUseNetworkResourcesForLiveStreamingWhilePausedRequest
              request) async {
    return SetCanUseNetworkResourcesForLiveStreamingWhilePausedResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setCanUseNetworkResourcesForLiveStreamingWhilePaused',
            request.toMap()))!);
  }

  @override
  Future<SetPreferredPeakBitRateResponse> setPreferredPeakBitRate(
      SetPreferredPeakBitRateRequest request) async {
    return SetPreferredPeakBitRateResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setPreferredPeakBitRate', request.toMap()))!);
  }

  @override
  Future<SeekResponse> seek(SeekRequest request) async {
    return SeekResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('seek', request.toMap()))!);
  }

  @override
  Future<SetAndroidAudioAttributesResponse> setAndroidAudioAttributes(
      SetAndroidAudioAttributesRequest request) async {
    return SetAndroidAudioAttributesResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'setAndroidAudioAttributes', request.toMap()))!);
  }

  @override
  Future<DisposeResponse> dispose(DisposeRequest request) async {
    return DisposeResponse.fromMap((await _channel
        .invokeMethod<Map<dynamic, dynamic>>('dispose', request.toMap()))!);
  }

  @override
  Future<ConcatenatingInsertAllResponse> concatenatingInsertAll(
      ConcatenatingInsertAllRequest request) async {
    return ConcatenatingInsertAllResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'concatenatingInsertAll', request.toMap()))!);
  }

  @override
  Future<ConcatenatingRemoveRangeResponse> concatenatingRemoveRange(
      ConcatenatingRemoveRangeRequest request) async {
    return ConcatenatingRemoveRangeResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'concatenatingRemoveRange', request.toMap()))!);
  }

  @override
  Future<ConcatenatingMoveResponse> concatenatingMove(
      ConcatenatingMoveRequest request) async {
    return ConcatenatingMoveResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'concatenatingMove', request.toMap()))!);
  }

  @override
  Future<AudioEffectSetEnabledResponse> audioEffectSetEnabled(
      AudioEffectSetEnabledRequest request) async {
    return AudioEffectSetEnabledResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'audioEffectSetEnabled', request.toMap()))!);
  }

  @override
  Future<void> darwinDelaySetTargetDelayTime(
      DarwinDelaySetDelayTimeRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDelaySetTargetDelayTime', request.toMap());
  }

  @override
  Future<void> darwinDelaySetTargetFeedback(
      DarwinDelaySetFeedbackRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDelaySetTargetFeedback', request.toMap());
  }

  @override
  Future<void> darwinDelaySetLowPassCutoff(
      DarwinDelaySetLowPassCutoffRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDelaySetLowPassCutoff', request.toMap());
  }

  @override
  Future<void> darwinDelaySetWetDryMix(
      DarwinDelaySetWetDryMixRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDelaySetWetDryMix', request.toMap());
  }

  @override
  Future<void> darwinDistortionSetWetDryMix(
      DarwinDistortionSetWetDryMixRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDistortionSetWetDryMix', request.toMap());
  }

  @override
  Future<void> darwinDistortionSetPreGain(
      DarwinDistortionSetPreGainRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDistortionSetPreGain', request.toMap());
  }

  @override
  Future<void> darwinDistortionSetPreset(
      DarwinDistortionSetPresetRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinDistortionSetPreset', request.toMap());
  }

  @override
  Future<void> darwinReverbSetPreset(
      DarwinReverbSetPresetRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinReverbSetPreset', request.toMap());
  }

  @override
  Future<void> darwinReverbSetWetDryMix(
      DarwinReverbSetWetDryMixRequest request) async {
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'darwinReverbSetWetDryMix', request.toMap());
  }

  @override
  Future<AndroidEqualizerGetParametersResponse> androidEqualizerGetParameters(
      AndroidEqualizerGetParametersRequest request) async {
    return AndroidEqualizerGetParametersResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'androidEqualizerGetParameters', request.toMap()))!);
  }

  @override
  Future<AndroidLoudnessEnhancerSetTargetGainResponse>
      androidLoudnessEnhancerSetTargetGain(
          AndroidLoudnessEnhancerSetTargetGainRequest request) async {
    return AndroidLoudnessEnhancerSetTargetGainResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'androidLoudnessEnhancerSetTargetGain', request.toMap()))!);
  }

  @override
  Future<AndroidEqualizerBandSetGainResponse> androidEqualizerBandSetGain(
      AndroidEqualizerBandSetGainRequest request) async {
    return AndroidEqualizerBandSetGainResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'androidEqualizerBandSetGain', request.toMap()))!);
  }

  @override
  Future<DarwinEqualizerBandSetGainResponse> darwinEqualizerBandSetGain(
      DarwinEqualizerBandSetGainRequest request) async {
    return DarwinEqualizerBandSetGainResponse.fromMap(
        (await _channel.invokeMethod<Map<dynamic, dynamic>>(
            'darwinEqualizerBandSetGain', request.toMap()))!);
  }

  @override
  Future<DarwinWriteOutputToFileResponse> darwinWriteOutputToFile() async {
    return DarwinWriteOutputToFileResponse.fromMap(
        (await _channel.invokeMethod('darwinWriteOutputToFile'))!);
  }

  @override
  Future<void> darwinStopWriteOutputToFile() async {
    await _channel.invokeMethod<void>('darwinStopWriteOutputToFile', null);
  }
}

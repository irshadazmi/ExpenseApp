import { useState } from "react";
import { Audio } from "expo-av";
import * as FileSystem from "expo-file-system";

export const useVoiceRecorder = () => {
  const [recording, setRecording] = useState<Audio.Recording | null>(null);
  const [recordingUri, setRecordingUri] = useState<string | null>(null);

  const startRecording = async () => {
    try {
      console.log("Requesting permissions...");
      await Audio.requestPermissionsAsync();

      await Audio.setAudioModeAsync({
        allowsRecordingIOS: true,
        playsInSilentModeIOS: true,
      });

      console.log("Starting recording...");
      const { recording } = await Audio.Recording.createAsync(
        Audio.RecordingOptionsPresets.HIGH_QUALITY
      );

      setRecording(recording);
    } catch (err) {
      console.error("Failed to start recording:", err);
    }
  };

  const stopRecording = async () => {
    console.log("Stopping recording...");
    if (!recording) return null;

    await recording.stopAndUnloadAsync();
    const uri = recording.getURI();
    setRecording(null);
    setRecordingUri(uri);

    return uri;
  };

  return {
    startRecording,
    stopRecording,
    recording,
    recordingUri,
    setRecordingUri,
  };
};

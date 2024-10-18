import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elegant Audio Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      home: const AudioPlayerScreen(),
    );
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _mutedAudioPlayer;
  late AudioPlayer _newAudioPlayer;
  double _playbackSpeed = 1.0;
  final List<double> _speedOptions = [0.5, 1.0, 1.5, 2.0];
  Map<Duration, String> _lyrics = {};
  int _currentLyricIndex = 0;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _mutedAudioPlayer.positionStream,
        _mutedAudioPlayer.bufferedPositionStream,
        _mutedAudioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    super.initState();
    _mutedAudioPlayer = AudioPlayer()..setAsset('assets/audio/hare1.mp3')..setVolume(0);
    _newAudioPlayer = AudioPlayer()..setAsset('assets/audio/ambient.mp3');

    _mutedAudioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _newAudioPlayer.pause();
      }
    });

    _newAudioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _newAudioPlayer.seek(Duration.zero);
        _newAudioPlayer.play();
      }
    });

    _mutedAudioPlayer.play();
    _newAudioPlayer.play();

    fetchLyrics('new artist', 'new song title').then((fetchedLyrics) {
      setState(() {
        _lyrics = fetchedLyrics;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    _mutedAudioPlayer.dispose();
    _newAudioPlayer.dispose();
    super.dispose();
  }

  Future<Map<Duration, String>> fetchLyrics(String artist, String title) async {
    // Simulating fetching LRC content
    // Replace this with actual lyrics for your new song
    final lrcContent = '''
[00:00.33]Hare Krishna Hare Krishna Krishna - Vivek Prakash
[00:24.01]Hare Krishno hare Krishno
[00:25.96]Krishno Krishno hare hare
[00:29.11]Hare Ram hare Ram
[00:30.98]Ram Ram hare hare
[00:33.97]Hare Krishno hare Krishno
[00:35.91]Krishno Krishno hare hare
[00:39.03]Hare Ram hare Ram
[00:40.75]Ram Ram hare hare
[00:43.96]Hare Krishno hare Krishno
[00:45.74]Krishno Krishno hare hare
[00:48.77]Hare Ram hare Ram
[00:50.64]Ram Ram hare hare
[00:53.59]Hare Krishno hare Krishno
[00:55.40]Krishno Krishno hare hare
[00:58.41]Hare Ram hare Ram
[01:00.26]Ram Ram hare hare
[01:03.23]Hare Krishno hare Krishno
[01:05.03]Krishno Krishno hare hare
[01:08.29]Hare Ram hare Ram
[01:10.10]Ram Ram hare hare
[01:13.14]Hare Krishno hare Krishno
[01:14.97]Krishno Krishno hare hare
[01:18.04]Hare Ram hare Ram
[01:19.80]Ram Ram hare hare
[01:22.90]Hare Krishno hare Krishno
[01:24.64]Krishno Krishno hare hare
[01:27.73]Hare Ram hare Ram
[01:29.49]Ram Ram hare hare
[01:32.68]Hare Krishno hare Krishno
[01:34.47]Krishno Krishno hare hare
[01:37.41]Hare Ram hare Ram
[01:39.41]Ram Ram hare hare
[01:42.29]Hare Krishno hare Krishno
[01:44.13]Krishno Krishno hare hare
[01:47.11]Hare Ram hare Ram
[01:48.96]Ram Ram hare hare
[01:51.77]Hare Krishno hare Krishno
[01:53.83]Krishno Krishno hare hare
[01:56.77]Hare Ram hare Ram
[01:58.54]Ram Ram hare hare
[02:01.53]Hare Krishno hare Krishno
[02:03.30]Krishno Krishno hare hare
[02:06.29]Hare Ram hare Ram
[02:08.14]Ram Ram hare hare
[02:11.25]Hare Krishno hare Krishno
[02:12.96]Krishno Krishno hare hare
[02:15.95]Hare Ram hare Ram
[02:17.69]Ram Ram hare hare
[02:20.80]Hare Krishno hare Krishno
[02:22.59]Krishno Krishno hare hare
[02:25.57]Hare Ram hare Ram
[02:27.32]Ram Ram hare hare
[02:30.19]Hare Krishno hare Krishno
[02:32.00]Krishno Krishno hare hare
[02:34.97]Hare Ram hare Ram
[02:36.80]Ram Ram hare hare
[02:39.41]Hare Krishno hare Krishno
[02:41.32]Krishno Krishno hare hare
[02:44.12]Hare Ram hare Ram
[02:45.98]Ram Ram hare hare
[02:48.78]Hare Krishno hare Krishno
[02:50.53]Krishno Krishno hare hare
[02:53.60]Hare Ram hare Ram
[02:55.43]Ram Ram hare hare
[02:58.41]Hare Krishno hare Krishno
[03:00.28]Krishno Krishno hare hare
[03:03.20]Hare Ram hare Ram
[03:05.09]Ram Ram hare hare
[03:07.91]Hare Krishno hare Krishno
[03:09.84]Krishno Krishno hare hare
[03:12.89]Hare Ram hare Ram
[03:14.69]Ram Ram hare hare
[03:17.50]Hare Krishno hare Krishno
[03:19.56]Krishno Krishno hare hare
[03:22.51]Hare Ram hare Ram
[03:24.27]Ram Ram hare hare
[03:29.29]Hare Krishno hare Krishno
[03:31.08]Krishno Krishno hare hare
[03:34.20]Hare Ram hare Ram
[03:36.37]Ram Ram hare hare
[03:39.15]Hare Krishno hare Krishno
[03:41.02]Krishno Krishno hare hare
[03:44.10]Hare Ram hare Ram
[03:45.91]Ram Ram hare hare
[03:48.95]Hare Krishno hare Krishno
[03:50.84]Krishno Krishno hare hare
[03:53.91]Hare Ram hare Ram
[03:55.66]Ram Ram hare hare
[03:58.71]Hare Krishno hare Krishno
[04:00.51]Krishno Krishno hare hare
[04:03.57]Hare Ram hare Ram
[04:05.44]Ram Ram hare hare
[04:08.40]Hare Krishno hare Krishno
[04:10.15]Krishno Krishno hare hare
[04:13.27]Hare Ram hare Ram
[04:15.18]Ram Ram hare hare
[04:18.30]Hare Krishno hare Krishno
[04:20.11]Krishno Krishno hare hare
[04:23.22]Hare Ram hare Ram
[04:25.00]Ram Ram hare hare
[04:28.05]Hare Krishno hare Krishno
[04:30.08]Krishno Krishno hare hare
[04:33.05]Hare Ram hare Ram
[04:34.77]Ram Ram hare hare
[04:37.85]Hare Krishno hare Krishno
[04:39.80]Krishno Krishno hare hare
[04:42.71]Hare Ram hare Ram
[04:44.66]Ram Ram hare hare
[04:47.44]Hare Krishno hare Krishno
[04:49.34]Krishno Krishno hare hare
[04:52.23]Hare Ram hare Ram
[04:54.17]Ram Ram hare hare
[04:57.03]Hare Krishno hare Krishno
[04:58.87]Krishno Krishno hare hare
[05:01.76]Hare Ram hare Ram
[05:03.64]Ram Ram hare hare
[05:06.70]Hare Krishno hare Krishno
[05:08.44]Krishno Krishno hare hare
[05:11.41]Hare Ram hare Ram
[05:13.28]Ram Ram hare hare
[05:15.95]Hare Krishno hare Krishno
[05:17.93]Krishno Krishno hare hare
[05:20.74]Hare Ram hare Ram
[05:22.58]Ram Ram hare hare
[05:25.22]Hare Krishno hare Krishno
[05:27.21]Krishno Krishno hare hare
[05:30.31]Hare Ram hare Ram
[05:32.03]Ram Ram hare hare
[05:35.06]Hare Krishno hare Krishno
[05:36.87]Krishno Krishno hare hare
[05:39.99]Hare Ram hare Ram
[05:41.74]Ram Ram hare hare
[05:44.59]Hare Krishno hare Krishno
[05:46.44]Krishno Krishno hare hare
[05:49.52]Hare Ram hare Ram
[05:51.21]Ram Ram hare hare
[05:54.16]Hare Krishno hare Krishno
[05:56.11]Krishno Krishno hare hare
[05:59.23]Hare Ram hare Ram
[06:01.07]Ram Ram hare hare
[06:04.24]Hare Krishno hare Krishno
[06:06.00]Krishno Krishno hare hare
[06:09.11]Hare Ram hare Ram
[06:10.84]Ram Ram hare hare
[06:14.05]Hare Krishno hare Krishno
[06:15.87]Krishno Krishno hare hare
[06:18.91]Hare Ram hare Ram
[06:20.74]Ram Ram hare hare
[06:24.14]Hare Krishno hare Krishno
[06:25.85]Krishno Krishno hare hare
[06:28.85]Hare Ram hare Ram
[06:30.53]Ram Ram hare hare
    ''';

    return parseLyrics(lrcContent);
  }

  Map<Duration, String> parseLyrics(String lrc) {
    final Map<Duration, String> lyricsMap = {};
    final RegExp regExp = RegExp(r'\[(\d{2}):(\d{2}\.\d{2})\](.*)');

    for (final line in lrc.split('\n')) {
      final match = regExp.firstMatch(line);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = double.parse(match.group(2)!);
        final lyric = match.group(3)?.trim() ?? '';
        lyricsMap[Duration(minutes: minutes, seconds: seconds.toInt())] = lyric;
      }
    }
    return lyricsMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade900, Colors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Now Playing',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hare Krishna',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Vivek Prakash',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return ProgressBar(
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _mutedAudioPlayer.seek,
                    thumbColor: Colors.white,
                    baseBarColor: Colors.white.withOpacity(0.24),
                    bufferedBarColor: Colors.white.withOpacity(0.24),
                    progressBarColor: Colors.white,
                    thumbGlowColor: Colors.white.withOpacity(0.24),
                    barHeight: 3.0,
                    thumbRadius: 8.0,
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Controls(
                mutedAudioPlayer: _mutedAudioPlayer,
                newAudioPlayer: _newAudioPlayer,
                speedOptions: _speedOptions,
                onSpeedChanged: (speed) {
                  setState(() {
                    _playbackSpeed = speed;
                    _mutedAudioPlayer.setSpeed(_playbackSpeed);
                  });
                },
                selectedSpeed: _playbackSpeed,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: StreamBuilder<PositionData>(
                        stream: _positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          final currentPosition = positionData?.position ?? Duration.zero;

                          _currentLyricIndex = _lyrics.keys.toList().indexWhere((duration) => duration > currentPosition) - 1;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _lyrics.entries.map((entry) {
                              final isActive = _currentLyricIndex >= 0 && entry.key == _lyrics.keys.elementAt(_currentLyricIndex);
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    color: isActive ? Colors.white : Colors.white70,
                                    fontSize: isActive ? 18 : 16,
                                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  final AudioPlayer mutedAudioPlayer;
  final AudioPlayer newAudioPlayer;
  final List<double> speedOptions;
  final Function(double) onSpeedChanged;
  final double selectedSpeed;

  const Controls({
    required this.mutedAudioPlayer,
    required this.newAudioPlayer,
    required this.speedOptions,
    required this.onSpeedChanged,
    required this.selectedSpeed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 36),
          onPressed: () {
            // Implement previous track functionality
          },
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: IconButton(
            icon: Icon(
              mutedAudioPlayer.playing ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 48,
            ),
            onPressed: () {
              if (mutedAudioPlayer.playing) {
                mutedAudioPlayer.pause();
                newAudioPlayer.pause();
              } else {
                mutedAudioPlayer.play();
                newAudioPlayer.play();
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white, size: 36),
          onPressed: () {
            // Implement next track functionality
          },
        ),
        PopupMenuButton<double>(
          icon: const Icon(Icons.speed, color: Colors.white),
          onSelected: onSpeedChanged,
          itemBuilder: (BuildContext context) {
            return speedOptions.map((speed) {
              return PopupMenuItem<double>(
                value: speed,
                child: Text('${speed}x'),
              );
            }).toList();
          },
          color: Colors.grey[850],
        ),
      ],
    );
  }
}
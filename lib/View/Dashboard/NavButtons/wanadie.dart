import 'package:flutter/material.dart';

class LyricsScreen extends StatefulWidget {
  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  // List of lyrics and their respective display times in seconds
  List<Map<String, dynamic>> lyricsWithTiming = [
    {"text": "If the world was ending", "delay": 1},
    {"text": "I'd wanna be next to you", "delay": 1},
    {"text": "If the party was over", "delay": 2},
    {"text": "And our time on Earth was through", "delay": 50},
    {"text": "I'd wanna hold you just for a while", "delay": 15},
    {"text": "And die with a smile", "delay": 13},
    {"text": "If the world was ending", "delay": 9},
    {"text": "I'd wanna be next to you", "delay": 10},
    {"text": "Right next to you", "delay": 30},
    {"text": "Next to you", "delay": 40},
  ];

  int currentLine = 0; // Tracks the current lyric line
  bool isPlaying = false; // Tracks whether lyrics are playing

  @override
  void initState() {
    super.initState();
    _startLyrics();
  }

  // Restarts the lyric playback
  void _restartLyrics() {
    setState(() {
      currentLine = 0;
      isPlaying = false; // Stop the current playback
    });
    _startLyrics(); // Start the lyrics again
  }

  // Starts or resumes displaying lyrics
  Future<void> _startLyrics() async {
    setState(() {
      isPlaying = true;
    });
    for (int i = 0; i < lyricsWithTiming.length; i++) {
      if (!isPlaying) break; // Stop if playback is interrupted
      await Future.delayed(Duration(seconds: lyricsWithTiming[i]['delay']));
      setState(() {
        currentLine = i + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _restartLyrics, // Restart lyrics on screen touch
      child: Scaffold(
        backgroundColor: Colors.black, // Background color
        appBar: AppBar(
          title: Text('Die with a Smile'),
          backgroundColor: Colors.white, // AppBar color
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: lyricsWithTiming.asMap().entries.map((entry) {
              int index = entry.key;
              String line = entry.value['text'];

              return AnimatedOpacity(
                duration: Duration(milliseconds: 500), // Fade-in animation
                opacity: currentLine > index ? 1.0 : 0.2, // Control visibility
                child: Text(
                  line,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

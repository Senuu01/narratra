import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:frontend/pages/download_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Go back to previous page
          },
          icon: Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth:100,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Settings", style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          const SizedBox(height: 40),
          Text(
            "Play & Audio Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade100,
                  ),
                  child: Icon(Ionicons.play_circle_outline, size: 26,
                  color: const Color.fromARGB(255, 214, 7, 7),),
                
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Playback Speed", 
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 227, 227),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Ionicons.chevron_forward_outline),
                )
                ],
            ),
          ),

          const SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade100,
                  ),
                  child: Icon(Ionicons.mic_outline, size: 26,
                  color: const Color.fromARGB(255, 214, 7, 7),),
                
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Change Voice Actor", 
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 227, 227),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Ionicons.chevron_forward_outline),
                )
                ],
            ),
          ),
          
          DownloadPage(),
        ],
      ),    
    );
  }
}

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_to_text/chat_message.dart';
import 'api_servecies.dart';



class SpeechScreen extends StatefulWidget {
const SpeechScreen({Key? key}) : super(key: key);

@override
_SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
SpeechToText speechToText = SpeechToText();
var text = "Hold the button and start speaking";
var isListening = false;
final List<ChatMessage> messages=[];
var scrollcontroller=ScrollController();

scrollMethod(){
  scrollcontroller.animateTo(scrollcontroller.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

@override
void initState() {
super.initState();
// Request audio recording permission before initializing the speechToText object
speechToText.initialize(onStatus: (status) {
print('status: $status');
}, onError: (error) {
print('error: $error');
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
floatingActionButton: AvatarGlow(
endRadius: 75.0,
animate: isListening,
duration: Duration(milliseconds: 500),
glowColor: Color.fromARGB(255, 12, 76, 37),
repeat: true,
repeatPauseDuration: Duration(milliseconds: 100),
showTwoGlows: true,
child: GestureDetector(
onTapDown: (details) async {
if (!isListening) {
var available = await speechToText.initialize(
onStatus: (status) {
print('status: $status');
},
onError: (error) {
print('error: $error');
},
);
if (available) {
setState(() {
isListening = true;
speechToText.listen(
onResult: (result) {
setState(() {
text = result.recognizedWords;
});
},
localeId: "en-US",
);
});
}
}
},
onTapUp: (details) async {
setState(() {
isListening = false;
});
speechToText.stop();
messages.add(ChatMessage(text: text, type: ChatMessageType.user));
var msg=await ApiServices.sendMessage(text.toString());
setState(() {
   messages.add(ChatMessage(text: msg, type: ChatMessageType.bot));
});
},
child: CircleAvatar(
backgroundColor: Color.fromARGB(255, 8, 105, 76),
radius: 35,
child: Icon(Icons.keyboard_voice),
),
),
),
appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 41, 105, 43),
leading: Icon(
Icons.mic_external_on,
color: Colors.white,
),
centerTitle: true,
title: Text(
'Speech to Voice',
style: TextStyle(fontSize: 20),
),
),
body: Container(

alignment: Alignment.center,

child: Column(
  children: [  
 
  Expanded(
  child: ClipRRect(
    // Set the border radius to 20
    child: Container(
      padding: EdgeInsets.all(20),
      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: scrollcontroller,
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context,int index){
          var chat=messages[index];
               return ChatBubble(chattext:chat.text,type: chat.type);
      })
    ),
  ),
),

  
]),
),
);
}
}



Widget ChatBubble({required chattext,required ChatMessageType? type}){
return Row(
 crossAxisAlignment:  CrossAxisAlignment.start,
  
  children: [ 
      CircleAvatar(
      backgroundColor: Color.fromARGB(255, 28, 93, 60),
      child: type ==  ChatMessageType.bot?  Icon(Icons.smart_toy,color: Colors.white,): Icon(Icons.person,color: Colors.white,),
  ),
    SizedBox(width: 12,),
    Expanded(
      child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only (bottom: 8),
      decoration:  BoxDecoration(
      color: type ==  ChatMessageType.bot? Color.fromARGB(255, 28, 88, 30): Colors.white,
      borderRadius: BorderRadius.only(
      topRight: Radius.circular (12), bottomRight: Radius.circular (12), bottomLeft: Radius.circular (12)
      ), ),// BoxDecoration
      child :  Text( 
      "$chattext",
      style: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      ), // TextStyl
      ), // Text
      ),
    ),
] )
;}// Container
# QueApli

I making some WhatsApp application like, why? because i want to learn flutter, the idea is to take the ideas
from one chat application, for the moment this is my playground to learn flutter

Important note:

This is an application like, so the interface can be similar, but will not be the same, i using flutter UX/UI widgets,
i'm not an UX/UI dev, so for the moment is very ugly, the same are for the features.

At this moment:

* Home screen with:
    * Chat messages (not dynamic) and go to selected chat
    * Show options based in tabs index
    * Go to photo
    * Go to contacts by button chat
* Camera screen
    * Take photo
    * Save in local
* Contacts
    * Show contacts from device
* Chat screen (very ugly)
    * Basic list of message
    * Input message and show it if added
* Options
    * Only the page

#TODO:

* Add maps (https://pub.dev/packages/google_maps_flutter or https://github.com/johnpryan/flutter_map)
* Add video recording (with camera plugin)
* Add voice recording (https://pub.dev/packages/audio_recorder)
* Add some image snapshot
* Add communication with server (send and receive message, audio and video)
* Work in the style
* Add some encryption

#Ideas:

* Add destroy message after x time (like mission impossibles messages)
* Create private and uniques encryption keys to share with unique user
(i don't know if legally speaking can be added, i know that having public program with encryption without backdoor
 can be illegal in most countries)
* Try https://github.com/cloudwebrtc/flutter-webrtc to make P2P communication (possible in mobile?)

#How to generate code from mobx annotations:

flutter packages pub run build_runner build

#How to run

You have two way to do it, with Android studio or direct with flutter cli

For any of the two way you have to:

* Have flutter, android sdk (or apple xcode, but i will only explain android).
For more information to how to install flutter https://flutter.dev/docs/get-started/install and android sdk https://developer.android.com/studio
* You have to check out this repo
* Create one virtual android device (or you can use your own android device)

By Android studio:
* Install flutter and dart plugins
* Open the projet
* Run the virtual device (Tools -> ADV manager -> Play [>])
* Select the device and main.dart file
* Play run (you have to wait several minutes, this is normal with flutter)

#Disclaimer

WhatsApp is one trend mark, i'm only using the application ideas like reference to learn flutter, other chat application have the same ideas, style, etc.

At any case, i have none relationship with this company and i think i respect the Brand Guidelines and copyright laws.
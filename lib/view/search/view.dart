import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/search/logic.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../theme/app_colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  int finalTimeoutSec = 5;
  /// This has to happen only once per app
  Future<void> _initSpeech() async {
    await _speech.initialize(finalTimeout: Duration(seconds: finalTimeoutSec));
  }


  void _startListening() {
    _speech.listen(
      onResult: (result) {
          Get.find<SearchLogic>().pickVoice(result.recognizedWords);
      },
    ).whenComplete(() => setState(() {}));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GetBuilder<SearchLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            children: [

              SizedBox(height: MediaQuery
                  .of(context)
                  .padding
                  .top * 2,),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.appBackground.withOpacity(0.3),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [

                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              controller: logic.controller,
                              focusNode: logic.focusNode,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefix: logic.controller.text.isNotEmpty ? null : AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText('Search anything',
                                          textStyle: TextStyle(
                                              color: Theme.of(context).hintColor
                                          ))
                                    ],
                                    repeatForever: true,
                                  ),
                              ),
                              onChanged: (String? str){
                                logic.search(str);
                              },
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              width: 1,
                              height: 25,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: const BoxDecoration(
                                  border: Border(right: BorderSide(
                                      width: 1, color: Colors.grey))
                              ),
                            ),

                            InkWell(
                              onTap: _speech.isListening ? null : (){
                                _startListening();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:
                                _speech.isListening ?
                                Image.asset(
                                    "assets/images/voice_recording.gif",
                                    height: 24,
                                    width: 24) : const Icon(
                                  Icons.mic_none_rounded,color: Colors.blue,),
                              ) ,
                            )
                          ],
                        )
                      ],
                    ),
                    if(logic.isSearching)...[
                      const LinearProgressIndicator(minHeight: 1.5),
                    ],
                  ],
                ),
              ),

              if(logic.model.isNotEmpty)...[
                Flexible(
                  child: ListView.builder(
                    itemCount: logic.model.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Get.toNamed(rsServiceDetailPage,arguments: { "id" : logic.model[index].id });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1,color: Colors.grey.shade300))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonImage(
                                width: 50,
                                height: 40,
                                radius: 5,
                                imageUrl: (logic.model[index].image?.isEmpty??true) ? null : "${ApiProvider.url}/${logic.model[index].image?[0]}",
                              ),

                              const SizedBox(width: 20,),

                              Text((logic.model[index].name??"").toCapitalizeFirstLetter(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),)
                            ],),
                        ),
                      );
                    },),
                )
              ],
              //voice_search
              if(_speech.isListening)...[
                const SizedBox(height: 100,),
                Image.asset("assets/images/voice_search.gif"),
              ]else...[
                if(logic.model.isEmpty)...[
                  const SizedBox(height: 100,),
                  Icon(logic.isSearching ? Icons.manage_search : Icons.search_off,size: 50,color: Colors.grey.shade300,)
                ]
              ],
            ],
          );
        },
      ),
    );
  }
}

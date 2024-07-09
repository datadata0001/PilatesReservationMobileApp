import 'package:flutter/material.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/pages/NBHomeScreen.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBDottedBorder.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase/supabase.dart';

class NBCreateNewAnnouncemetScreen extends StatefulWidget {
  static String tag = '/NBCreateNewAnnouncemetScreen';
  final SupabaseClient supabaseClient;

  NBCreateNewAnnouncemetScreen({required this.supabaseClient});

  @override
  NBCreateNewAnnouncemetScreenState createState() => NBCreateNewAnnouncemetScreenState();
}

class NBCreateNewAnnouncemetScreenState extends State<NBCreateNewAnnouncemetScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController articleController = TextEditingController();
  bool isAudioArticle = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // Gerekli ilk yüklemeler burada yapılabilir.
  }

  Future<void> _addArticle() async {
    final title = titleController.text;
    final content = articleController.text;

    if (title.isEmpty || content.isEmpty) {
      toast('Please fill in all fields');
      return;
    }

    final duyuru = Duyuru(
      title: title,
      content: content,
      isAudioArticle: isAudioArticle,
      createdAt: DateTime.now(),
      id: null, // ID veritabanı tarafından otomatik oluşturulacak.
    );

    final response = await widget.supabaseClient
        .from('duyuru')
        .insert({
          'is_audio_article': duyuru.isAudioArticle,
          'created_at': duyuru.createdAt?.toIso8601String(),
          'title': duyuru.title,
          'content': duyuru.content,
        });

    if (response.error == null) {
      toast('Duyuru yayımlama başarılı!');
      finish(context);
    } else {
      toast('Duyuru yayımlama başarısız oldu!: ${response.error!.message}');
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'Yeni Duyuru Oluştur!'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            16.height,
            16.height,
            Text('Başlık', style: boldTextStyle()),
            8.height,
            nbAppTextFieldWidget(titleController, 'Duyuru Başlığı', TextFieldType.OTHER),
            16.height,
            Text('Duyuru Metni', style: boldTextStyle()),
            8.height,
            TextFormField(
              controller: articleController,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                filled: true,
                fillColor: grey.withOpacity(0.1),
                hintText: 'Metin giriniz..',
                hintStyle: secondaryTextStyle(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            16.height,
            Text('Duyuru Sayfası', style: boldTextStyle()),
            8.height,
            16.height,
            16.height,
            nbAppButtonWidget(
              context,
              'Yayınla!',
              () {
                _addArticle();
              },
            ),
            16.height,
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}

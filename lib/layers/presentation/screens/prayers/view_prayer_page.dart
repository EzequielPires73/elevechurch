import 'package:elevechurch/core/helpers/date.dart';
import 'package:elevechurch/layers/data/repositories/prayer_repository_imp.dart';
import 'package:elevechurch/layers/domain/entities/prayer.dart';
import 'package:elevechurch/layers/presentation/widgets/cards/card_prayer_comment.dart';
import 'package:elevechurch/layers/presentation/widgets/not_found.dart';
import 'package:flutter/material.dart';

class ViewPrayerPage extends StatefulWidget {
  final Prayer prayer;
  const ViewPrayerPage({super.key, required this.prayer});

  @override
  State<ViewPrayerPage> createState() => _ViewPrayerPageState();
}

class _ViewPrayerPageState extends State<ViewPrayerPage> {
  late Prayer prayer;
  final TextEditingController content = TextEditingController();
  bool isPraying = false;
  bool isMyPraying = false;
  bool isLoading = false;

  @override
  void initState() {
    prayer = widget.prayer;
    super.initState();
  }

  /* refresh() async {
    var res = await _prayerRepository.findOne(prayer.id);
    if (res != null) {
      setState(() {
        prayer = res;
      });
    }
  } */

  /* handleSubmitPraying() async {
    try {
      var res = await _prayerRepository.changePraying(prayer.id);

      if (res != null) {
        setState(() {
          prayer = res;
        });
      }
    } catch (error) {
      print(error);
    }
  } */

  /*  handleSubmitComment() async {
    try {
      if (content.text != '') {
        setState(() {
          isLoading = true;
        });
        var res = await _prayerRepository.comment(prayer.id, content.text);
        content.clear();
        if (res != null) {
          setState(() {
            prayer = res;
          });
        }
      }
    } catch (error) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Detalhes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: isMyPraying
            ? [
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete_outline)),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.indigo.shade100,
              ),
              child: Text(
                reasonOptions
                    .firstWhere((e) => e.enumValue == prayer.reason)
                    .name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.indigo, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: prayer.user?.avatar != null
                        ? Image.network(
                            prayer.user!.avatar!,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(Icons.person_outline),
                          ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                prayer.user != null
                    ? Text(
                        prayer.user?.name ?? '',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              prayer.description,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  prayer.createdAt != null
                      ? formatFullDate(prayer.createdAt!)
                      : '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.amber.shade600 : Colors.black87,
                  ),
                ),
                isPraying
                    ? FilledButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        label: Text(
                          '${prayer.praying != null && prayer.praying!.length > 0 ? '${prayer.praying!.length} ' : ''}Orando',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Orar',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Comentários',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: prayer.comments != null && prayer.comments!.length > 0
                  ? prayer.comments!
                      .map((e) => CardPrayerComment(
                            comment: e,
                          ))
                      .toList()
                  : [const NotFound(text: 'Nenhum comentário encontrado.')],
            )
          ],
        ),
      ),
      bottomSheet: SafeArea(
        bottom: true,
        child: BottomAppBar(
          elevation: 8,
          shadowColor: Colors.black38,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: content,
                    decoration: InputDecoration(
                      hintText: 'Adicione um comentário',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 54,
                  height: 54,
                  child: IconButton.filled(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.indigo),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                    onPressed: () {},
                    icon: isLoading
                        ? CircularProgressIndicator()
                        : Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

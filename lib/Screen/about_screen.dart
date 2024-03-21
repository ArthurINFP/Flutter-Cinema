import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static String screenName = '/LoginScreen';
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = Text(
      'The Batman',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
    );
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xff1A2232),
          appBar: AppBar(
            backgroundColor: const Color(0xff1A2232),
            centerTitle: true,
            title: title,
            bottom: _buildTabBar(),
          ),
          body: const TabBarView(children: [
            AboutTab(),
            Icon(
              Icons.flight,
              size: 300,
              color: Colors.white,
            )
          ]),
        ));
  }

  TabBar _buildTabBar() {
    return TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: const Color(0xffFF8036),
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text('About',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFF8036))),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text('Sessions',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFF8036))),
          ),
        ]);
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: 500,
                height: 200,
                color: Colors.black,
              ),
              _sectionRating(),
              _sectionContent()
            ]),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 343,
          height: 56,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
              color: const Color(0xffFF8036),
              borderRadius: BorderRadius.circular(8)),
          child: const Text(
            'Select Session',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _sectionRating() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              '8.3',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'IMDB',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff637394)),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              '7.9',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Kinopoisk',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff637394)),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionContent() {
    String aboutTextData =
        "When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city's hidden corruption and question his family's involvement.";
    TextStyle contentTextStyle = const TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);
    TextStyle titleTextStyle = contentTextStyle.copyWith(
        fontWeight: FontWeight.w400, color: const Color(0xff637394));
    return Container(
      color: const Color(0xff1A2232),
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          aboutTextData,
          style: contentTextStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Certificate',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Runtime',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Release',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Gerne',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Director',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Cast',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '16+',
                      style: contentTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '02:56',
                      style: contentTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '2022',
                      style: contentTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Action, Crime, Drama',
                      style: contentTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Matt Reeves',
                      style: contentTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Robert Pattinson, Zoë Kravitz, Jeffrey Wright, Colin Farrell, Paul Dano, John Turturro, 	Andy Serkis, Peter Sarsgaard',
                      style: contentTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                )),
          ],
        )
      ]),
    );
  }
}

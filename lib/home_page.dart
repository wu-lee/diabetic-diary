import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'database.dart';
import 'entities/dish_topic.dart';
import 'entities/ingredient_topic.dart';
import 'entity_topic.dart';
import 'overview_topic.dart';
import 'topic.dart';
import 'translation.dart';



class HomePage extends StatefulWidget {
  final Database db;

  HomePage({Key? key, required this.db}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Symbol title = #HomePage;

  @override
  _HomePageState createState() => _HomePageState(
      initialTopicIndex: 0,
      topics: [
        OverviewTopic(id: #Overview, icon: Icons.follow_the_signs, db: db),
        IngredientTopic(entities: db.ingredients, db: db),
        DishTopic(entities: db.dishes, db: db),
      ],
    );
}

class _HomePageState extends State<HomePage> {
  int currentTopicIndex;
  final List<Topic> topics;

  _HomePageState({required this.topics, required int initialTopicIndex}) :
      currentTopicIndex = initialTopicIndex;

  void _setTopic(int topicIndex) async {
    setState(() {
      currentTopicIndex = topicIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: currentTopicIndex,
      length: topics.length,
      child: StatefulBuilder(
        builder: (context, setBuilderState) {
          final TabController? tabController = DefaultTabController.of(context);
          tabController?.addListener(() {
            if (tabController.indexIsChanging) {
              setBuilderState(() { currentTopicIndex = tabController.index; });
            }
          });
          final currentTopic = topics[currentTopicIndex];
          var floatingActionButton; //optional
          if (currentTopic is EntityTopic)
            floatingActionButton = currentTopic.buildFloatingActionButton(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(TL8(widget.title)),
              bottom: TabBar(
                tabs: topics.map((topic) =>
                  Tab(
                    icon: Icon(topic.icon),
                    text: TL8(topic.id),
                  )
                ).toList(),
              ),
            ),
            body: TabBarView(
              children: topics.map((topic) => topic.buildTabContent(context))
                  .toList(),
            ),
            floatingActionButton: floatingActionButton,
          );
        },
      )
    );
  }
}


import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/QuestionBank.dart';
import 'Question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  List<Widget> scoreKeeper = [];
  List<Question> questions = QuestionBank.questions;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[index].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  chekAnswer(true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.grey,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState(() {
                  chekAnswer(false);
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }

  Icon addCheck() {
    return Icon(Icons.check, color: Colors.cyan);
  }

  Icon addCross() {
    return Icon(Icons.close, color: Colors.grey);
  }

  void chekAnswer(bool answer) {
    if (questions[index].answer == answer)
      updateScoreKeeper(addCheck());
    else
      updateScoreKeeper(addCross());

    index++;
    if (index == questions.length) index = 0;
  }

  void updateScoreKeeper(Icon icon) {
    // Check for space in score bar and update acordingly
    if (scoreKeeper.length >= questions.length) {
      alertEnding();
    } else {
      scoreKeeper.add(icon);
    }
  }

  void alertEnding() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text('End of the game!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Congratulations, you have reached the end of the game.'),
              ],
            ),
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            PlatformDialogAction(
              child: Text('Finish'),
              actionType: ActionType.Preferred,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/


import 'package:flutter/material.dart';

import 'Quiz_page.dart';

class Assessment extends StatefulWidget {
  const Assessment({Key? key}) : super(key: key);

  @override
  State<Assessment> createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  List<String> depression = [
    'Are you having thoughts that you would be better off dead, or of hurting yourself?',
    'Are you having trouble concentrating on things such as reading the newspaper or watching TV?',
    'Are you feeling bad about yourself (ex. feel like a failure or constantly let your family down)?',
    'Do you feel lonely and that people are not interested in you?',
    'Do you have a poor appetite or are you overeating?',
    'Are you feeling tired or having little energy?',
    'Are you having trouble falling or staying asleep, or sleeping too much?',
    'Do you have episodes of crying that are hard to stop?',
    'Are you feeling down, depressed, or hopeless?',
    'Do you have little interest or pleasure in doing things?'
  ];

  List<String> anxiety = [
    'Are you feeling nervous, anxious, or on edge?',
    'Are you feeling unable to stop or control worrying?',
    'Do you have difficulties with sleep(including waking early, finding it hard to fall asleep)?',
    'Are you worrying too much about different things?',
    'Do you have stomach problems such as feeling sick or stomach cramps?',
    'Are you having trouble relaxing?',
    'Are you so restless that it is hard to sit still?',
    'Do you experience shortness of breath?',
    'Are you feeling easily annoyed or irritable?',
    'Are you feeling as if something awful might happen?'
  ];

  List<String> ptsd = [
    'Have you experienced, witnessed, or heard from a person close to you (family or friend) about a threatening event(actual or threatened death, serious injury, or sexual violence)?',
    'Since this event occurred, do you experience recurrent involuntary memories or dreams that make you suffer?',
    'Do you become distressed by sights, sounds, smells or feelings that remind you of the event?',
    'Do you try not to think about the traumatic event?',
    'Do you try not to see people, go to places or see objects that are associated with the event?',
    'Do you have trouble remembering an important aspect of the event?',
    'Because of the event, do you now believe that no one can be trusted? ',
    'Are you uninterested in activities you enjoyed before the traumatic event?',
    'Is it very difficult for you to feel happiness, satisfaction or love?',
    'Could any of the new behaviors or thoughts you are experiencing be attributed to substance use or a medical condition (ie. a head injury)?',
    'Have these issues caused significant difficulties in your relationships, work or school?',
  ];

  List<String> schizophrenia = [
    'Are you experiencing any brain fog?',
    'Are you struggling with maintaining social relationships, employment,  and/or academic demands?',
    'Do you feel that you are being tracked, followed, or watched at home or outside?',
    'Are you having trouble seeing things or are you seeing things that are not there?',
    'Do you struggle to trust that what you are thinking is real?',
    'Do you have a sense that others are controlling your thoughts and emotions?',
    'Do you struggle to keep up with daily living tasks such as showering, changing clothes, paying bills, cleaning, cooking, etc.?',
    'Do you feel that you have powers that other people cannot understand or appreciate? ',
    'Do you find it difficult to organize or keep track of your thinking?',
    'Do other people say that it is difficult for you to stay on subject or for them to understand you?',
  ];

  List<String> addiction = [
    'Are you using substances to numb any physical or emotional pain?',
    'Do you feel like you should cut down on your substance use?',
    'Are you feeling guilty about using substances?',
    'Is anyone annoying you by criticizing your substance use?',
    'Do you feel that your substance use significantly decreases your ability to function?',
    'Are you using substances as soon as you wake up in the morning?'
  ];

  List<String> bipolar = [
    'Are you much more talkative or speak much faster than usual at times?',
    'Have there been times when you were much more active or did many more things than usual?',
    'Have there been times when you have felt both high (elated) and low (depressed) at the same time?',
    'Does your self-confidence ranges from great self-doubt to equally overconfidence?',
    'Is there a great variations in the quantity or quality of your work?',
    'For no obvious reason, sometimes have you been very angry or hostile?',
    'Sometimes you are mentally dull and at other times you think very creatively?',
    'At times you are greatly interested in being with people and at other times you just want to be left alone with your thoughts?',
    'At some times you have great optimism and at other times equally great pessimism?',
    'Some of the time you show much tearfulness and crying and at other times you laugh and joke excessively?',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment Test', style: Theme.of(context).textTheme.displayLarge),


      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height / 3,
                width: 0.90 * width,
                child: Image(
                  image: AssetImage('assets/test01.gif'),
                ),
              ),
              SizedBox(height: height / 40),
              Text(
                'Choose self assesment test based on following disorders',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: height / 20),
              InkWell(
                child: ListTile(
                  title: Center(child: Text('Depression', style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              depression,
                              8,
                              'Depression',
                              [Colors.blue, Colors.greenAccent])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text('Anxiety', style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              anxiety,
                              7,
                              'Anxiety and stress',
                              [Colors.red, Colors.pinkAccent])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text('PTSD', style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              ptsd, 5, 'PTSD', [Colors.cyan, Colors.teal])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text('Schizophrenia', style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              schizophrenia,
                              8,
                              'Schizophrenia',
                              [Colors.purple, Colors.indigo])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text('Addiction', style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(addiction, 6,
                              'Addiction', [Colors.brown, Colors.blueGrey])));
                },
              ),
              SizedBox(height: height / 60),
            ],
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(fontSize: 15, color: Colors.black);
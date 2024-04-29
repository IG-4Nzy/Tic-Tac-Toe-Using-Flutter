import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  String winner = '';
  String player = 'PLAYER1';
  int p1 = 0;
  int p2 = 0;
  String status = 'False';
  List<List<String>> boxes = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double width = screenSize / 3 - 30;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Tic ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Tac ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Toe',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                resetGame();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  status == 'False' ? 'Your turn' : '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: player == 'PLAYER1' ? Colors.red : Colors.blue,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner != '' && winner != 'draw' ? '$winner WON' : '',
                  style: TextStyle(
                    color: winner == 'PLAYER1' ? Colors.red : Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  winner != '' && winner == 'draw' ? 'DRAW' : '',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Player X',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 250, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  child: Text(
                    'Player O',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 17, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        '$p1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 120,
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        '$p2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            // Game board
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < 3; j++)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 131, 128, 128),
                            ),
                          ),
                          width: width,
                          height: width,
                          child: TextButton(
                            onPressed: () {
                              MakeMove(i, j);
                            },
                            child: Text(
                              boxes[i][j],
                              style: TextStyle(
                                fontSize: 42,
                                color: boxes[i][j] == 'X'
                                    ? Colors.red
                                    : Color.fromARGB(255, 17, 0, 255),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 112, 112, 112),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      newGame();
                    },
                    child: Text(
                      'New Game',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void MakeMove(int i, int j) {
    if (status != 'True' && boxes[i][j].isEmpty) {
      setState(() {
        if (player == 'PLAYER1') {
          boxes[i][j] = 'X';
          player = 'PLAYER2';
        } else {
          boxes[i][j] = 'O';
          player = 'PLAYER1';
        }
        calculate(i, j);
      });
    }
  }

  void calculate(int i, int j) {
    for (int row = 0; row < 3; row++) {
      if (boxes[row][0] == boxes[row][1] &&
          boxes[row][0] == boxes[row][2] &&
          boxes[row][0] != '') {
        setState(() {
          if (boxes[row][0] == 'X') {
            winner = 'PLAYER1';
            status = 'True';
            p1++;
          } else {
            winner = 'PLAYER2';
            status = 'True';
            p2++;
          }
        });
      }
    }

    for (int col = 0; col < 3; col++) {
      if (boxes[0][col] == boxes[1][col] &&
          boxes[0][col] == boxes[2][col] &&
          boxes[0][col] != '') {
        setState(() {
          if (boxes[col][0] == 'X') {
            winner = 'PLAYER1';
            status = 'True';
            p1++;
          } else {
            winner = 'PLAYER2';
            status = 'True';
            p2++;
          }
        });
      }
    }

    if ((boxes[0][0] == boxes[1][1] && boxes[0][0] == boxes[2][2]) ||
        (boxes[0][2] == boxes[1][1] && boxes[0][2] == boxes[2][0])) {
      if (boxes[1][1] != '') {
        setState(() {
          if (boxes[1][1] == 'X') {
            winner = 'PLAYER1';
            status = 'True';
            p1++;
          } else {
            winner = 'PLAYER2';
            status = 'True';
            p2++;
          }
        });
      }
    }

    bool draw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (boxes[i][j] == '') {
          draw = false;
          break;
        }
      }
    }
    if (draw && status != 'True') {
      setState(() {
        winner = 'draw';
        status = 'True';
      });
    }
  }

  void resetGame() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          boxes[i][j] = '';
        }
      }
      winner = '';
      player = 'PLAYER1';
      status = 'False';
    });
  }

  void newGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Color.fromARGB(255, 19, 19, 19),
          content: Container(
            decoration: BoxDecoration(),
            width: 200,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you sure ? \n It will cause to progress loss !',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            for (int i = 0; i < 3; i++) {
                              for (int j = 0; j < 3; j++) {
                                boxes[i][j] = '';
                              }
                            }
                            winner = '';
                            player = 'PLAYER1';
                            p1 = 0;
                            p2 = 0;
                            status = 'False';
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dating/data/db/entity/app_user.dart';
import 'package:dating/data/db/entity/chat.dart';
import 'package:dating/data/db/entity/match.dart';
import 'package:dating/data/db/entity/swipe.dart';
import 'package:dating/data/db/remote/firebase_database_source.dart';
import 'package:dating/data/provider/user_provider.dart';
import 'package:dating/ui/screens/matched_screen.dart';
import 'package:dating/ui/widgets/custom_modal_progress_hud.dart';
import 'package:dating/ui/widgets/rounded_icon_button.dart';
import 'package:dating/ui/widgets/swipe_card.dart';
import 'package:dating/util/constants.dart';
import 'package:dating/util/utils.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _ignoreSwipeIds;
  Color _iconColor = Colors.yellowAccent;
  Future<AppUser> loadPerson(String myUserId) async {
    if (_ignoreSwipeIds == null) {
      // ignore: deprecated_member_use
      _ignoreSwipeIds = List<String>();
      var swipes = await _databaseSource.getSwipes(myUserId);
      print(swipes);
      for (var i = 0; i < swipes.size; i++) {
        Swipe swipe = Swipe.fromSnapshot(swipes.docs[i]);
        _ignoreSwipeIds.add(swipe.id);

      }
      _ignoreSwipeIds.add(myUserId);

    }
    print(_ignoreSwipeIds);
    var res = await _databaseSource.getPersonsToMatchWith(1, _ignoreSwipeIds);
    if (res.docs.length > 0) {
      var userToMatchWith = AppUser.fromSnapshot(res.docs.first);
      return userToMatchWith;
    } else {
      return null;
    }
  }

  void personSwiped(AppUser myUser, AppUser otherUser, bool isLiked) async {
    _databaseSource.addSwipedUser(myUser.id, Swipe(otherUser.id, isLiked));
    _ignoreSwipeIds.add(otherUser.id);

    if (isLiked == true) {
      setState(() {
        _iconColor=Colors.deepOrangeAccent;
      });
      if (await isMatch(myUser, otherUser) == true) {
        _databaseSource.addMatch(myUser.id, Match(otherUser.id));
        _databaseSource.addMatch(otherUser.id, Match(myUser.id));
        String chatId = compareAndCombineIds(myUser.id, otherUser.id);
        _databaseSource.addChat(Chat(chatId, null));

        Navigator.pushNamed(context, MatchedScreen.id, arguments: {
          "my_user_id": myUser.id,
          "my_profile_photo_path": myUser.profilePhotoPath,
          "other_user_profile_photo_path": otherUser.profilePhotoPath,
          "other_user_id": otherUser.id
        });
      }
    }
    setState(() {
      _iconColor=Colors.yellowAccent;
    });
  }

  Future<bool> isMatch(AppUser myUser, AppUser otherUser) async {
    DocumentSnapshot swipeSnapshot =
        await _databaseSource.getSwipe(otherUser.id, myUser.id);
    if (swipeSnapshot.exists) {
      Swipe swipe = Swipe.fromSnapshot(swipeSnapshot);

      if (swipe.liked == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return FutureBuilder<AppUser>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                  inAsyncCall:
                      userProvider.user == null || userProvider.isLoading,
                  child: (userSnapshot.hasData)
                      ? FutureBuilder<AppUser>(

                          future: loadPerson(userSnapshot.data.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasData) {
                              return Center(
                                child: Container(
                                    child: Text('No users',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4)),
                              );
                            }
                            if (!snapshot.hasData) {
                              return CustomModalProgressHUD(
                                inAsyncCall: true,
                                child: Container(),
                              );
                            }
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SwipeCard(person: snapshot.data),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 45),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RoundedIconButton(
                                                  onPressed: () {
                                                    personSwiped(
                                                        userSnapshot.data,
                                                        snapshot.data,
                                                        false);
                                                  },
                                                  iconData: Icons.clear,
                                                  buttonColor:
                                                      kColorPrimaryVariant,
                                                  iconSize: 30,
                                                ),
                                                RoundedIconButton(
                                                 buttonColor: _iconColor,
                                                  onPressed: () {
                                                    personSwiped(
                                                        userSnapshot.data,
                                                        snapshot.data,

                                                        true);
                                                    setState(() {
                                                      _iconColor=Colors.deepOrange;
                                                    });
                                                  },
                                                  iconData: Icons.favorite,
                                                  iconSize: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      /*    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RoundedIconButton(
                                          onPressed: () {
                                            personSwiped(
                                                userSnapshot.data,
                                                snapshot.data,
                                                false);
                                          },
                                          iconData: Icons.clear,
                                          buttonColor:
                                              kColorPrimaryVariant,
                                          iconSize: 30,
                                        ),
                                        RoundedIconButton(
                                          onPressed: () {
                                            personSwiped(
                                                userSnapshot.data,
                                                snapshot.data,
                                                true);
                                          },
                                          iconData: Icons.favorite,
                                          iconSize: 30,
                                        ),
                                      ],
                                      ),*/
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Container(),
                );
              },
            );
          },
        )));
  }
}

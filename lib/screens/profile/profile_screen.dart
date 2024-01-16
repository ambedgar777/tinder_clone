import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:tinder_clone/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tinder_clone/blocs/setup_data_bloc/setup_data_bloc.dart';
import 'package:tinder_clone/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tinder_clone/screens/profile/add_photo_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    descriptionController.text = context.read<AuthenticationBloc>().state.user!.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            context.read<AuthenticationBloc>().state.user!.description =
                descriptionController.text;
          });
          print(context.read<AuthenticationBloc>().state.user!);
          context.read<SetupDataBloc>().add(
              SetupRequired(context.read<AuthenticationBloc>().state.user!));
        },
        child: const Icon(
          CupertinoIcons.check_mark,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Profile Screen'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(const SignOutRequired());
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Photos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 16,
                    ),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () async {
                          if (!(context
                                  .read<AuthenticationBloc>()
                                  .state
                                  .user!
                                  .pictures
                                  .isNotEmpty &&
                              (i <
                                  context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user!
                                      .pictures
                                      .length))) {
                            var photos = await pushNewScreen(
                              context,
                              screen: const AddPhotoScreen(),
                            );
                            if (photos != null && photos.isNotEmpty) {
                              setState(() {
                                context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user!
                                    .pictures
                                    .addAll(photos);
                              });
                            }
                          }
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .user!
                                          .pictures
                                          .isNotEmpty &&
                                      (i <
                                          context
                                              .read<AuthenticationBloc>()
                                              .state
                                              .user!
                                              .pictures
                                              .length)
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(8),
                                        image: (context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .user!
                                                    .pictures[i] as String)
                                                .startsWith('https')
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .state
                                                      .user!
                                                      .pictures[i],
                                                ),
                                              )
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                  File(context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .state
                                                      .user!
                                                      .pictures[i]),
                                                ),
                                              ),
                                      ),
                                    )
                                  : DottedBorder(
                                      color: Colors.grey.shade700,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(8),
                                      dashPattern: const [6, 6, 6, 6],
                                      padding: EdgeInsets.zero,
                                      strokeWidth: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user!
                                                .pictures
                                                .isNotEmpty &&
                                            (i <
                                                context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .user!
                                                    .pictures
                                                    .length)
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .user!
                                                    .pictures
                                                    .remove(context
                                                        .read<
                                                            AuthenticationBloc>()
                                                        .state
                                                        .user!
                                                        .pictures[i]);
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Image.asset(
                                                  'assets/images/clear.png',
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Image.asset(
                                                'assets/images/add.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'About Me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: TextFormField(
                  maxLines: 10,
                  minLines: 1,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: 'About me',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

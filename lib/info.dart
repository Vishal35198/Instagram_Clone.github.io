// StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   return const ResposiveLayout(
//                       webScreenLayout: WebScreenLayout(),
//                       mobileScreenLayout: MobileScreen());
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('${snapshot.error}'),
//                   );
//                 }
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: primaryColor,
//                   ),
//                 );
//               }
//               return const LoginScreen();
//             },
//           )
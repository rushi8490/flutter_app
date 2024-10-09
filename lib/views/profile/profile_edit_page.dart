// import 'package:flutter/material.dart';
//
// import '../../core/components/app_back_button.dart';
// import '../../core/constants/constants.dart';
//
// class ProfileEditPage extends StatelessWidget {
//   const ProfileEditPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cardColor,
//       appBar: AppBar(
//         leading: const AppBackButton(),
//         title: const Text(
//           'Profile',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(AppDefaults.padding),
//           padding: const EdgeInsets.symmetric(
//             horizontal: AppDefaults.padding,
//             vertical: AppDefaults.padding * 2,
//           ),
//           decoration: BoxDecoration(
//             color: AppColors.scaffoldBackground,
//             borderRadius: AppDefaults.borderRadius,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /* <----  First Name -----> */
//               const Text("First Name"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Last Name -----> */
//               const Text("Last Name"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Phone Number -----> */
//               const Text("Phone Number"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Gender -----> */
//               const Text("Gender"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Birthday -----> */
//               const Text("Birthday"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Password -----> */
//
//               /* <---- Birthday -----> */
//               const Text("Password"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.visiblePassword,
//                 textInputAction: TextInputAction.next,
//                 obscureText: true,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Submit -----> */
//               const SizedBox(height: AppDefaults.padding),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   child: const Text('Save'),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart'; // for picking images
//
// import '../../core/components/app_back_button.dart';
// import '../../core/constants/constants.dart';
//
// class ProfileEditPage extends StatefulWidget {
//   const ProfileEditPage({super.key});
//
//   @override
//   State<ProfileEditPage> createState() => _ProfileEditPageState();
// }
//
// class _ProfileEditPageState extends State<ProfileEditPage> {
//   String? selectedDropdownValue;
//   String? imageName;
//   String? imagePath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cardColor,
//       appBar: AppBar(
//         title: const Text(
//           'Add Product',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(AppDefaults.padding),
//           padding: const EdgeInsets.symmetric(
//             horizontal: AppDefaults.padding,
//             vertical: AppDefaults.padding * 2,
//           ),
//           decoration: BoxDecoration(
//             color: AppColors.scaffoldBackground,
//             borderRadius: AppDefaults.borderRadius,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /* <---- Upload Image -----> */
//               const Text("Upload Image"),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? result = await FilePicker.platform.pickFiles(
//                     type: FileType.image,
//                   );
//                   if (result != null) {
//                     setState(() {
//                       imagePath = result.files.single.path;
//                       imageName = result.files.single.name;
//                     });
//                   }
//                 },
//                 child: const Text('Choose Image'),
//               ),
//               if (imageName != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text('Selected Image: $imageName'),
//                 ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Image Name -----> */
//               const Text("Image Name"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Quantity -----> */
//               const Text("Quantity"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//
//               /* <---- Company Name -----> */
//               const Text("Company Name"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Dropdown Menu -----> */
//               const Text("Department"),
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: selectedDropdownValue,
//                 items: <String>['decoration', 'kitchen', '']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedDropdownValue = newValue;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: AppDefaults.padding),
//               const Text("Assigned To"),
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: selectedDropdownValue,
//                 items: <String>['in department', 'not in department', '']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedDropdownValue = newValue;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Dropdown Menu -----> */
//               const Text("Status"),
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: selectedDropdownValue,
//                 items: <String>['decoration head', 'kitchen', 'admin']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedDropdownValue = newValue;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//
//               const SizedBox(height: AppDefaults.padding),
//               /* <---- Purchase Date -----> */
//               const Text("Purchase Date"),
//               const SizedBox(height: 8),
//               TextFormField(
//                 keyboardType: TextInputType.datetime,
//                 textInputAction: TextInputAction.done,
//               ),
//               const SizedBox(height: AppDefaults.padding),
//
//               /* <---- Submit -----> */
//               const SizedBox(height: AppDefaults.padding),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   child: const Text('Save'),
//                   onPressed: () {
//                     // Handle save action
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart'; // For formatting the selected date
import 'package:http/http.dart' as http;

import '../../core/routes/app_routes.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final storage = GetStorage(); // Get GetStorage instance
  String? selectedDepartment;
  String? assignedTo;
  String? status;
  String? imageName;
  String? imagePath;
  DateTime? selectedPurchaseDate;

  // Controllers to retrieve text inputs
  final TextEditingController imageNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();

  Future<void> submitForm() async {
    // Create the multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://avd-assests.uc.r.appspot.com/api/v1/products'),
    );

    String? cookie = await storage.read('cookie');
    print(cookie);

    // Set the headers (including cookie header)
    request.headers.addAll({
      'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundaryY3ZzJCA0mRQzwulq',
      'Cookie': cookie.toString(), // Replace with actual cookie
    });
    print('Image Name: ${imageNameController.text}');
    print('Quantity: ${quantityController.text}');
    print('Company Name: ${companyNameController.text}');
    print('Department: $selectedDepartment');
    print('Assigned To: $assignedTo');
    print('Status: $status');
    print('Purchase Date: ${purchaseDateController.text}');
    if (imagePath != null) {
      print('Image Path: $imagePath');
    }
    // Add static form data
    request.fields['name'] = imageNameController.text.toString();
    request.fields['company'] = companyNameController.text.toString();
    request.fields['purchaseDate'] = purchaseDateController.text.toString();
    request.fields['department'] = selectedDepartment.toString();
    request.fields['assignedTo'] = assignedTo.toString();
    request.fields['status'] = status.toString();
    request.fields['quantity']  = quantityController.text.toString();

    // Add the image file if selected
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'productImg', // Field name in API
        imagePath!,
      ));
    }
    // print(_image?.path);

    // Send the request
    try {
      var response = await request.send();

      // Check response status code
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Success: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product Added Successfully')),
        );
        Navigator.pushNamed(context, AppRoutes.entryPoint);
      } else {
        print('Error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
        Navigator.pushNamed(context, AppRoutes.entryPoint);
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network Error')),
      );
    }

  }

  // Method to show DatePicker
  Future<void> _selectPurchaseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Earliest date allowed
      lastDate: DateTime(2101), // Latest date allowed
    );
    if (picked != null && picked != selectedPurchaseDate) {
      setState(() {
        selectedPurchaseDate = picked;
        // Format the selected date and display it in the text field
        purchaseDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Change this to your theme's background color
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          decoration: BoxDecoration(
            color: Colors.white, // Change this to your theme's card color
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* <---- Upload Image -----> */
              const Text("Upload Image"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    setState(() {
                      imagePath = result.files.single.path;
                      imageName = result.files.single.name;
                    });
                  }
                },
                child: const Text('Choose Image'),
              ),
              if (imageName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Selected Image: $imageName'),
                ),
              const SizedBox(height: 16.0),

              /* <---- Image Name -----> */
              const Text("Image Name"),
              const SizedBox(height: 8),
              TextFormField(
                controller: imageNameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),

              /* <---- Quantity -----> */
              const Text("Quantity"),
              const SizedBox(height: 8),
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),

              /* <---- Company Name -----> */
              const Text("Company Name"),
              const SizedBox(height: 8),
              TextFormField(
                controller: companyNameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),

              /* <---- Dropdown Menu -----> */
              const Text("Department"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedDepartment,
                items: <String>['decoration', 'kitchen']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDepartment = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              /* <---- Assigned To -----> */
              const Text("Assigned To"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: assignedTo,
                items: <String>['decoration head', 'kitchen', 'admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    assignedTo = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              /* <---- Status -----> */
              const Text("Status"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: status,
                items: <String>['in department', 'not department']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              /* <---- Purchase Date -----> */
              const Text("Purchase Date"),
              const SizedBox(height: 8),
              TextFormField(
                controller: purchaseDateController,
                readOnly: true, // Prevents manual input
                onTap: () => _selectPurchaseDate(context), // Opens Date Picker
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today), // Calendar icon
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              /* <---- Submit -----> */
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    // Print all the data entered by the user
                    print('Image Name: ${imageNameController.text}');
                    print('Quantity: ${quantityController.text}');
                    print('Company Name: ${companyNameController.text}');
                    print('Department: $selectedDepartment');
                    print('Assigned To: $assignedTo');
                    print('Status: $status');
                    print('Purchase Date: ${purchaseDateController.text}');
                    if (imagePath != null) {
                      print('Image Path: $imagePath');
                    }
                    submitForm();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



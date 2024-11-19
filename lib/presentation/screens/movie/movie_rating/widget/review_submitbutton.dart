import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReviewSubmitButton<B extends BlocBase<S>, S> extends StatelessWidget {
 final BlocWidgetListener<S> listener;
  final VoidCallback onPressed;
  final String buttonText;

  const ReviewSubmitButton({
    super.key,
   required this.listener,
    required this.onPressed,
    this.buttonText = 'Submit', 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40.0),
    
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(buttonText),
        ),
  
    );
  }
}

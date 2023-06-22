## URBAN SOUND CLASSIFICATION

The front end has been built and developed on Flutter and Dart. The Python code for classification was integrated by using a TfLite code.

  ![image](https://github.com/halwaisaloni1/audio-classification-python-flutter/assets/50180528/b1f464be-4bf3-47cc-b265-6b4a7c360f8e)

The user can navigate to the next page from where he/she can upload audio to view the classification results.

  ![image](https://github.com/halwaisaloni1/audio-classification-python-flutter/assets/50180528/1bbe62d0-ea8c-40be-9338-de40a218bde7)

  ![image](https://github.com/halwaisaloni1/audio-classification-python-flutter/assets/50180528/216c9bc0-9ceb-42ec-a390-ea3da0c3148a)


Here, if you see, it takes a few seconds to get the classification results of any audio because this audio file is sent to the Python file to be tested and then a result is returned and added to Firebase. Then, the results are fetched from Firebase storage itself.
Next comes the Audios page and the audio details page where any user can see the audios which have been uploaded by any other user. The user can then click on an audio and view the audio details. The audio details page allows the user to listen to an audio and to view the classification for the same.

  ![image](https://github.com/halwaisaloni1/audio-classification-python-flutter/assets/50180528/46d38bf3-8fd8-4d70-a348-ff46a697a570)

As seen above in all the screens of the UI, a very minimalistic approach is taken up and well-thought of from the user perspective to make it as simple and easy for them to follow along with.
The entire front-end is connected to the backend and all the data comes from the Firebase storage. The Firebase storage has two collections, Audios and Classification.

The Audios collection stores all the audios which are uploaded by the user and also stores the classification result. The Classification collection keeps a track of all the classes for the graphs which are there on the home page.

  ![image](https://github.com/halwaisaloni1/audio-classification-python-flutter/assets/50180528/979a8464-72c5-4474-aba0-143b7d295d3b)

  ![image](https://github.com/halwaisaloni1/audio-classification-python-flutter/assets/50180528/5dc12259-580f-4849-8eac-d548947b15eb)

As it is visible, the testing result is pretty accurate. The “values” field stores the classification returned by the model.

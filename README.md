# fascia

20.04.2024
Ho cambiato le icone dell'app.
Vedi https://www.geeksforgeeks.org/flutter-changing-app-icon/
per come generare e poi inserire nel progetto le icone trasparenti.
Al sito https://www.appicon.co/#app-icon
si possono creare le icone a partire da una immagine.

Al sito: https://www.fotor.com/blog/how-to-make-transparent-background-in-paint/
si mostra come inserire uno sfondo trasparente in Paint 3D.

Al sito: https://stackoverflow.com/questions/40933304/how-to-create-an-icon-for-visual-studio-with-just-mspaint-and-visual-studio
si mostra come creare una icona a partire da una imagine.

Ho trovato un programma Drop Icons per convertire immagini in icone.


Comando di compilazione:
flutter build apk --split-per-abi --no-tree-shake-icons
Cartella con apk:
[project]/build/app/outputs/apk/release/app-arm64-v8a-release.apk
it will download, modify and install fixed appimage under ~/Games/turtle-wow/
to manually run the app open ~/Games/turtle-wow/

to be more open, all it does is pull the twow launcher from turtle-wow.org, remove ALL bundled libs 
and then it will repack into a new appimage that will use SYSTEM libs instead, removing all leftover files and keeping only the fixed appimage...

to install copy and paste below command:
```
git clone https://github.com/JonasAlv/twow-launcher-fix.git
cd twow-launcher-fix
chmod +x install.sh
sh install.sh
```

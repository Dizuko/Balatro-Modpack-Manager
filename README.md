# Balatro-Modpack-Manager
A primitive setup to maintian and switch between modpacks for Balatro

A simple use of Batch files and Symbiotic Links to create an ease of making and switching between modpacks.
Due to functions being in batch files, a change of modpack can be controled by things like a stream deck

First practice safe modding, back up your "%APPDATA%\Balatro\Mods" folder
Download and unzip, then place the Mods.store folder into your %APPDATA%\Balatro
NOT in %APPDATA\Balatro\Mods!!

Then run the First Setup.bat, this will ask you to name your current modpack, it will take your current modlist from within the ...\Mods folder and copy it to a new folder within ...\Mods.store
After this it will then delete your ...\Mods folder and create a Symbiotic link to take place of the Mods folder.

You are set up, you old modlist is made into a modpack. To create more modpacks, simply run the New Modpack.bat and input a name. The .bat will do the rest.

To change between backs, simply run the sw.~~.bat where the ~~ is the name of the folder/modpack you want to switch to.

NOTE: Do not change the names of folders manually as this will mess with the .bats functionality to switch between modpacks


To make a one click shortcut to change pack and launch, make a copy of the chosen modpacks sw.~~.bat; and edit the .bat adding this line one line above "endlocal"

`start "" "{BALATRO.EXE PATH HERE}"`

Once this edit has been made, make a shortcut of the copied .bat file and place on desktop. You can then apply an icon. This shotcut will switch the modpack and then launch the game in one click

@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning dxDUnit..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %delphiooLib%\ooText\ (
  @echo "Clonning ooText..."
  git clone https://github.com/VencejoSoftware/ooText.git %delphiooLib%\ooText\
  call %delphiooLib%\ooText\batch\get_dependencies.bat
)

if not exist %delphi3rdParty%\rxMemDataset\ (
  @echo "Clonning rxMemDataset..."
  git clone https://github.com/VencejoSoftware/rxMemDataset %delphi3rdParty%\rxMemDataset\
)